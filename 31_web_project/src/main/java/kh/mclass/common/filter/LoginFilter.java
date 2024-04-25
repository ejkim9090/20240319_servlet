package kh.mclass.common.filter;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(filterName = "loginFilter", urlPatterns = {"/board/*", "/mypage/*"} )
public class LoginFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse res = (HttpServletResponse)response;
		HttpSession session = req.getSession();

		if(session.getAttribute("sssLogin") == null) {
			/* 단순히 login 페이지로 이동함 */
			//res.sendRedirect(req.getContextPath() + "/login");
			
			/* 
			 로그인 성공후에 원래 가려던 URL 로 이동하기
			 GET 방식 전송 파라메터도 가지고 이동하기
			 */
			String url=req.getRequestURI();	//원래 가려던 URL 정보 읽어오기
			String query=req.getQueryString();  // Get query 문자열로 읽어오기 ( a=xxx&b=xxx&c=xxx )
			System.out.println("Req url  : "+ url);
			System.out.println("Req query: "+ query);
			String encodedUrl=null;
			if(query==null) { //전송 파라미터가 없다면 
				encodedUrl=url;
			}else {
				encodedUrl=url+"?"+query;
			}
			// 경고 msg도 띄워주기
			String alertMsg = "";
			alertMsg = "&alertMsg="+URLEncoder.encode("login.","UTF-8");
			//리다일렉트 시킬때 원래 목적지 정보를 url 라는 파라미터 명으로 같이 보낸다.
			res.sendRedirect(req.getContextPath() + "/login?url="+encodedUrl + alertMsg);
		} else {
			String url=req.getRequestURI();
			System.out.println("Req url: "+url);
			chain.doFilter(request, response);
		}
	}

}
