package com.stock.util;

import javax.servlet.http.HttpServletRequest;

public class GetClientIp {

	/**
	 * 접속된 클라이언트 아이피 추출
	 * @ HttpServletRequest request
	 * - 프록시나 Load Balancer 같은것을 거쳐 오게되는 경우
	 *   request.getRemoteAddr() 호출로는 정확한 아이피를 가져오지 못하여 메소드 구현
	 *   localhost에서 테스트 하는 경우 0:0:0:0:0:0:0:1 값으로 넘어 오는 경우가 있다.
	 *	  이 값은 IPv6 에서 IPv4의 127.0.0.1 과 같은 값이다.
	 *	 Tomcat으로  개발시 이게 문제가 되는 경우 vm arguments에  -Djava.net.preferIPv4Stack=true 값을 넣어 주면 된다.
	 */
	public static String getClientIP(HttpServletRequest request) {
		String ip = request.getHeader("X-FORWARDED-FOR");
		if(ip == null || ip.length() == 0) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0) {
			ip = request.getRemoteAddr();
		}
		if(ip.equals("0:0:0:0:0:0:0:1")) {
			ip = "127.0.0.1";
		}
		return ip;
	}
}
