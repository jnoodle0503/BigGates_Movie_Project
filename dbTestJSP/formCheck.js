const logout = document.getElementById("logout");

function loginCheck(obj) {
	if(!obj.id.value || obj.id.value.trim().length == 0) {
		alert("아이디가 입력되지 않았습니다.");
		obj.id.value = "";
		obj.id.focus();
		return false;
	}
	if(!obj.password.value || obj.password.trim().length == 0) {
		alert("비밀번호를 입력해주세요.");
		obj.password.value = "";
		obj.password.focus();
		return false;
	}
	return true;
}

function handleLogout() {
	alert("로그아웃 되었습니다!");
	location.href="main.jsp?logout=yes";
}

logout.addEventListener("click", handleLogout);