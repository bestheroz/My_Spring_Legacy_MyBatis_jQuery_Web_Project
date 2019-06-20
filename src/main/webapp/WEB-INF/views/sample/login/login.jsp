<%@ page session="false" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@include file="/WEB-INF/include/include.jsp" %>

<my:html cookie="YES" validator="YES">
    <main role="main" class="flex-shrink-0">
        <div class="container">
            <form class="form-signin">
                <img class="mb-4" src="/docs/4.3/assets/brand/bootstrap-solid.svg" alt="" width="72" height="72">
                <h1 class="h3 mb-3 font-weight-normal">Bestheroz's Spring-Maven-Bootstrap Web
                    <small>ver.190319</small>
                </h1>
                <label for="memberId" class="sr-only">아이디</label>
                <input type="email" class="form-control" id="memberId" title="아이디" placeholder="아이디를 입력하세요." maxlength="9" required autofocus>
                <label for="memberPw" class="sr-only">Password</label>
                <input type="password" class="form-control" id="memberPw" title="비밀번호" placeholder="비밀번호를 입력하세요." maxlength="20" required>
                <div class="checkbox mb-3">
                    <button type="button" class="btn btn-default" onclick="clickSaveId();">
                        <i class="far fa-check-square" id="save_id" title="ID 저장"></i>
                        ID 저장
                    </button>
                </div>
                <button class="btn btn-lg btn-primary btn-block" type="button" onclick="proc();"><i class="fas fa-sign-in-alt"></i>
                    로그인
                </button>
                <div class="col-sm-offset-2" style="margin-top: 10px;">
                    <p class="text-muted text-center" style="font-size: 16px;">
                        테스트 [ ID / Password ] => [
                        <strong>1 / 1</strong>
                        ] 입니다.
                    </p>
                </div>
                <p class="mt-5 mb-3 text-muted">&copy; 2016-2019</p>
            </form>
        </div>
    </main>
    <my:footer/>
    <script data-for="ready">
        $(document).ready(function () {
            $('#memberPw, #memberId').on('keydown', function (event) {
                if (event.key === 'Enter') {
                    proc();
                }
            });
            let savedLoginId = MyCookie.getCookie("savedLoginId");
            if (savedLoginId !== null) {
                $('#memberId').val(savedLoginId);
                $('#save_id').removeClass('fa-square').addClass('fa-check-square');
            }
        });
    </script>
    <script>
        function proc() {
            if (MyValidator.validate($('form.form-horizontal'), true) !== null) {
                return;
            }
            let param = {
                memberId: $('#memberId').val(),
                memberPw: CryptoJS.SHA512($('#memberPw').val()).toString()
            };
            MyAjax.excute('${CONTEXT_PATH}/sample/login/loginProcess.json', param, {
                autoResultFunctionTF: false
            }).done(function (response) {
                if (!_.startsWith(response.responseCode, 'S')) {
                    alert(response.responseMessage);
                    return;
                }
                if ($('#save_id').hasClass('fa-check-square')) {
                    MyCookie.setCookie("savedLoginId", $('#memberId').val(), 30);
                } else {
                    MyCookie.removeCookie("savedLoginId");
                }
                window.location.reload();
            });
        }

        function clickSaveId() {
            if ($('#save_id').hasClass('fa-check-square')) {
                $('#save_id').addClass('fa-square').removeClass('fa-check-square');
            } else {
                $('#save_id').removeClass('fa-square').addClass('fa-check-square');
            }
        }
    </script>
    <script defer="defer" src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.9-1/crypto-js.min.js"></script>

</my:html>