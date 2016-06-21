/**
 * 
 */
package com.jksb.land.repository.staticData;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.jksb.land.entity.staticData.ReferencedPriceEntity;

/**
 * @author Willian Chan
 *
 */
public interface ReferencedPriceDao extends JpaSpecificationExecutor<ReferencedPriceEntity>,
		PagingAndSortingRepository<ReferencedPriceEntity,Long> {
	/**
	 * 根据农场编码、土地类型、土地登记查询参考价格实体
	 * @param farmCode
	 * @param refLandType
	 * @param refLandLevel
	 * @return
	 */
	@Query("select refPrice from ReferencedPriceEntity refPrice where refPrice.farmCode= ?1 and refPrice.refLandType= ?2 and refPrice.refLandLevel= ?3")
	public ReferencedPriceEntity getReferencedPrice(String farmCode,String refLandType,String refLandLevel);
}
