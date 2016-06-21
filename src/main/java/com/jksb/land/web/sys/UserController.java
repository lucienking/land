package com.jksb.land.web.sys;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jksb.land.entity.sys.UserEntity;
import com.jksb.land.service.sys.UserService;

public class UserController {
	@Autowired
	private UserService userService;

	@RequestMapping(method = RequestMethod.GET)
	public String list(@RequestParam(value = "id", defaultValue = "-1") Long id,Model model) {
		UserEntity user = userService.getUser(id);
		model.addAttribute("user", user);

		return "account/adminUserList";
	} 
}
