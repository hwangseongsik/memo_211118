<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="d-flex justify-content-center">
	<div class="sign-up-box">
		<h1 class="mb-4">회원가입</h1>
		<form id="signUpForm" method="post" action="/user/sign_up">
			<table class="sign-up-table table table-bordered">
				<tr>
					<th class="bg-secondary">* 아이디<br></th>
					<td>
						<div class="d-flex">
							<input type="text" id="loginId" name="loginId" class="form-control" placeholder="아이디를 입력하세요.">
							<button type="button" id="loginIdCheckBtn" class="btn btn-success">중복확인</button><br>
						</div>
						
						<%-- 아이디 체크 결과 --%>
						<%-- d-none 클래스: display none (보이지 않게) --%>
						<div id="idCheckLength" class="small text-danger d-none">ID를 4자 이상 입력해주세요.</div>
						<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 아이디입니다.</div>
						<div id="idCheckOk" class="small text-success d-none">사용가능한 아이디입니다.</div>
					</td>
				</tr>
				<tr>
					<th class="bg-secondary">* 비밀번호</th>
					<td><input type="password" id="password" name="password" class="form-control" placeholder="비밀번호를 입력하세요."></td>
				</tr>
				<tr>
					<th class="bg-secondary">* 비밀번호 확인</th>
					<td><input type="password" id="confirmPassword" class="form-control" placeholder="비밀번호를 입력하세요."></td>
				</tr>
				<tr>
					<th class="bg-secondary">* 이름</th>
					<td><input type="text" id="name" name="name" class="form-control" placeholder="이름을 입력하세요."></td>
				</tr>
				<tr>
					<th class="bg-secondary">* 이메일</th>
					<td><input type="text" id="email" name="email" class="form-control" placeholder="이메일 주소를 입력하세요."></td>
				</tr>
			</table>
			<br>
		
			<button type="button" id="signUpBtn" class="btn btn-primary float-right">회원가입</button>
		</form>
	</div>
</div>

<script>
$(document).ready(function() {
	// 아이디 중복확인
	$('#loginIdCheckBtn').on('click', function() {
		// alert("중복");
		
		let loginId = $('#loginId').val().trim();
		
		// 경고문구 초기화
		$('#idCheckLength').addClass('d-none');
		$('#idCheckDuplicated').addClass('d-none');
		$('#idCheckOk').addClass('d-none');
		
		if (loginId.length < 4) {
			$('#idCheckLength').removeClass('d-none');
			return;
		}
		
		$.ajax({
			url: "/user/is_duplicated_id"
			, data: {"loginId":loginId}
			, success: function(data) {
				if (data.result) { // 중복인 경우
					$('#idCheckDuplicated').removeClass('d-none');
				} else { // 사용 가능
					$('#idCheckOk').removeClass('d-none');
				}
			}
			, error: function(e) {
				alert("아이디 중복확인에 실패했습니다. 관리자에게 문의해주세요.")
			}
		});
	});
	
	// 회원가입
	$('#signUpBtn').on('click', function() {
		// alert("클릭");
		
		let loginId = $('#loginId').val().trim();
		if (loginId == '') {
			alert("아이디를 입력해주세요.");
			return;
		}
		
		let password = $('#password').val().trim();
		let confirmPassword = $('#confirmPassword').val().trim();
		if (password == '' || confirmPassword == '') {
			alert("비밀번호를 입력해주세요.");
			return;
		}
		
		if (password != confirmPassword) {
			alert("비밀번호가 일치하지 않습니다. 다시 입력하세요.");
			$('#password').val('');
			$('#confirmPassword').val('');
			return;
		}
		
		let name = $('#name').val().trim();
		if (name == '') {
			alert("이름을 입력해주세요.");
			return;
		}
		
		let email = $('#email').val().trim();
		if (email == '') {
			alert("이메일을 입력해주세요.");
			return;
		}
		
		// 아이디 중복확인이 완료 되었는지 확인
		//-- idCheckOk <div> 클래스에 d-none이 없으면 사용 가능
		// idCheckOk d-none이 있으면 => alert을 띄운다.
		if ($('#idCheckOk').hasClass('d-none')) {
			alert("아이디 중복확인을 다시 해주세요.");
			return;
		}
		
		// 회원가입 서버 요청
		// 1. submit
		// 2. ajax
		
		// 1. submit
		// $('form')[0].submit();
		
		// 2. ajax
		let url = $('#signUpForm').attr('action'); // form에 있는 action주소 가져오기
		let params = $('#signUpForm').serialize(); // form에 있는 값들을 한번에 보낼수 있다.
		
		$.post(url, params)
		.done(function(data) {
			if (data.result == "success") {
				alert("가입을 환영합니다! 로그인을 해주세요.");
				location.href = "/user/sign_in_view";
			} else {
				alert("가입에 실패했습니다. 다시 시도해주세요.");
			}
			
		});
	});
});
</script>