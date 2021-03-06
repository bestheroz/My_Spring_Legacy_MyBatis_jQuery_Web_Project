package com.github.bestheroz.standard.context.filter.https;

import org.springframework.web.filter.GenericFilterBean;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class HttpsFilter extends GenericFilterBean {

    @Override
    public void doFilter(final ServletRequest request, final ServletResponse response, final FilterChain chain) throws IOException, ServletException {
        final HttpsRequestWrapper httpsRequest = new HttpsRequestWrapper((HttpServletRequest) request);
        httpsRequest.setResponse((HttpServletResponse) response);
        chain.doFilter(httpsRequest, response);
    }
}
