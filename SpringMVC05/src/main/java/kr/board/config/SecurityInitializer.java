package kr.board.config;

import org.springframework.security.web.context.AbstractSecurityWebApplicationInitializer;

public class SecurityInitializer extends AbstractSecurityWebApplicationInitializer {
	//내부적으로 DelegatingFilterProxy를 스프링에 등록하여 스프링 시큐리티를 내부적으로 동작시킨다
}
