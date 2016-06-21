package com.jksb.land.service.rent;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.jksb.land.entity.contract.Contract;
import com.jksb.land.entity.contract.PrePayingBudget;
import com.jksb.land.entity.contract.StepCalculateDetail;
import com.jksb.land.entity.contract.StepCalculateVersion;
import com.jksb.land.service.contract.PrePayingBudgetService;
import com.jksb.land.service.contract.StepCalculateDetailService;
import com.jksb.land.service.staticData.ReferencedPriceService;

/**
 * 租金计算service
 * 
 * @author wangxj
 * 
 */

@Component
@Transactional
public class RentCalculateService {

	@Autowired
	private ReferencedPriceService referencedPriceService;
	
	@Autowired
	private StepCalculateDetailService stepCalculateDetailService;
	
	@Autowired
	private PrePayingBudgetService prePayingBudgetService;
	
	private double initRental = 0;
	
	private double initArea = 0;
	
	private double basePrice = 0;
	
	private StringBuffer calculateProcess = new StringBuffer();
	
	/**
	 * 获得基础地价
	 */
	public void getBaseInfo(Contract contract) {
		String farmCode = contract.getResidentsGroup().getCommunityEntity()
				.getFarmCode();
		String refLandType = contract.getLandType();
		String refLandLevel = contract.getLandLevel();
		basePrice = referencedPriceService.getReferencedPrice(farmCode,
				refLandType, refLandLevel);
		if(basePrice == 0) basePrice = contract.getSigningPrice();
		initArea = contract.getUseArea();
		calculateProcess.append("basePrice:").append(basePrice).append(";baseArea:").append(initArea).append(";");
	}

	/**
	 * 减去保障地面积
	 */
	public void minusEnsure(Contract contract) {
		double affordArea = contract.getAffordableArea();
		initArea = initArea - affordArea;
		calculateProcess.append("minusEnsureArea:").append("-").append(affordArea).append("=").append(initArea).append(";");
	}

	/**
	 * 减去减免面积
	 */
	public void minusFavourable(Contract contract) {
		double favourableArea = contract.getAffordableArea();
		initArea = initArea - favourableArea;
		calculateProcess.append("minusFavourableArea:").append("-").append(favourableArea).append("=").append(initArea).append(";");
	}

	/**
	 * 阶梯计价
	 */
	public void stepCalculate(Contract contract) {
		if(contract.getIsStepedCount() == "Y"){
			calculateProcess.append("stepCalculate:");
			StepCalculateVersion scv = contract.getStepCalculateVersion();
			List<StepCalculateDetail> scds = stepCalculateDetailService.getPriceByStepVersionAndRange(scv.getVersionCode(), initArea);
			StepCalculateDetail last = scds.get(scds.size() - 1);
			for(StepCalculateDetail scd:scds){
				double coeff = scd.getSetpCoefficient()+1;
				double area = scd.getStepLong();
				if(scd.equals(last)) area = initArea - scd.getStepStart();
				initRental += basePrice * area * coeff;
				calculateProcess.append(basePrice).append("*").append(area).append("*").append(coeff).append("=").append(initRental).append(";");
			}
		}
	}

	/**
	 * 5年递增
	 */
	public double fiveYearImprove(Contract contract,int num) {
		double resultRental = 0;
		if(contract.getIsRegularlyRaise() == "Y"){
			double rate = 1+ contract.getRatePerFiveYear();
			for(int i=2;i<num;i++) rate = rate*rate;
			resultRental = initRental*rate;
			calculateProcess.append("fiveYearImprove：").append(initRental).append("*").append(rate).append("=").append(initRental).append(";");
		}else{
			resultRental = initRental;
		}
		return resultRental;
	}

	/**
	 * 计算租金过程
	 * @param contract
	 * @param num
	 */
	public void calculate(Contract contract){
		initRental = 0;
		initArea = 0;
		basePrice = 0;
		calculateProcess = new StringBuffer();
		this.getBaseInfo(contract);
		this.minusEnsure(contract);
		this.minusFavourable(contract);
		this.stepCalculate(contract);
	}
	
	/**
	 * 初始化应缴费用
	 * 
	 * @param contract
	 * @return
	 */
	public Contract initPrePayingBuget(Contract contract) {
		
		List<String> years = getYearList(contract.getStartDate(),contract.getExpiredDate());
		List<PrePayingBudget> prePayingBudgetList = new ArrayList<PrePayingBudget>();
		this.calculate(contract);
		double resultRental = initRental;
		for(int i=0;i<years.size();i++){
			int num = (int) Math.floor(i/5);
			if(num>0) resultRental = this.fiveYearImprove(contract,num);
			PrePayingBudget prePayingBudget = new PrePayingBudget();
			prePayingBudget.setSpecificYear(years.get(i));
			prePayingBudget.setPaidRental(0);
			prePayingBudget.setPaidBudget(resultRental);
			prePayingBudget.setPayingRental(resultRental);
			prePayingBudget.setIsPartialAreaFree("N");
			prePayingBudget.setIsPartialRentFree("N");
			prePayingBudget.setIsDiscount("N");
			prePayingBudget.setCalculateProcess(calculateProcess.toString());
			prePayingBudgetList.add(prePayingBudget);
		}
		
		contract.setPrePayingBudget(prePayingBudgetList);
		return contract;
	}
	
	/**
	 * 初始化应缴费用
	 * 
	 * @param contract
	 * @return
	 */
	public PrePayingBudget initPrePayingBuget(Contract contract,PrePayingBudget prePayingBudget) {
		this.calculate(contract);
		prePayingBudget.setPaidBudget(initRental);
		prePayingBudget.setPayingRental(initRental);
		prePayingBudget.setCalculateProcess(calculateProcess.toString());
		return prePayingBudget;
	}

	/**
	 * 缴费年份
	 * @param start
	 * @param end
	 * @return
	 */
	private List<String> getYearList(Date start, Date end) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
		List<String> years = new ArrayList<String>();

		Calendar c1 = Calendar.getInstance();
		Calendar c2 = Calendar.getInstance();
		c1.setTime(start);
		c2.setTime(end);
		c2.add(Calendar.YEAR, -1);
		while (c1.compareTo(c2) <= 0) {
			Date prex = c1.getTime();
			String str = sdf.format(prex);
			c1.add(Calendar.YEAR, 1);
			Date hrex = c1.getTime();
			String str2 = sdf.format(hrex);
			years.add(str + "-" + str2 );
		}
		return years;
	}
}
