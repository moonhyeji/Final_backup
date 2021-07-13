package com.kh.bnpp;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class KitchenmapController {
	
	@RequestMapping(value = "/kitchenmap.do", method = RequestMethod.GET)
	public String kitchenmap() {
		
		return "kitchenmap";
	}

}
