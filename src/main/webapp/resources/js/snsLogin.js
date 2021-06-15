// (히든값은 구글은 로그인되있으면 자동로그인되서 체크를 위해 히든값추가)
		$("#googleLogin").click(function() {
			
    	$("#googlebtn").attr('value', "true");

	});	
//구글 로그인
function onSignIn(googleUser) {
    // Useful data for your client-side scripts:
    var profile = googleUser.getBasicProfile();
//     console.log("ID: " + profile.getId()); // Don't send this directly to your server!
//     console.log('Full Name: ' + profile.getName());
//     console.log('Given Name: ' + profile.getGivenName());
//     console.log('Family Name: ' + profile.getFamilyName());
//     console.log("Image URL: " + profile.getImageUrl());
//     console.log("Email: " + profile.getEmail());

    // The ID token you need to pass to your backend:
    var id_token = googleUser.getAuthResponse().id_token;
//     console.log("ID Token: " + id_token);
	
    $("#googleToken").attr('value', id_token);
	
    
    if($("#googleToken") !== '' && $("#googlebtn").val() === "true"){
    	
    	   $.ajax({
    	        url:"/user/googleLogin",
    	        type:"post",
    	        contentType: 'application/json; charset=UTF-8',
    	        data: JSON.stringify({
    	           "idToken" : id_token
    	        }),
    	        success: function (data) {
    	         console.log("성공");
   	             window.location.href = "/notices/list";
    	         alert("구글 계정 로그인 성공");
    	        },
    	        
    	        error : function(xhr,status,error) {
    	         console.log(error);
    	        },
    	   });
    	
    
    }
 
}; 



//카카오 로그인 인증
  function loginWithKakao() {
	  
      // SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해 주세요.
      Kakao.init('eed580099cdf2241c049ba5cebf1ebb4');

      // SDK 초기화 여부를 판단합니다.
      console.log(Kakao.isInitialized());

    Kakao.Auth.login({
      success: function(authObj) {
        console.log(JSON.stringify(authObj));
         console.log("성공");
         kakaoRequest();			//카카오 사용자 정보 요청함수
      },
      fail: function(err) {
        alert(JSON.stringify(err))
         console.log("에러");
      },
    })
  }
 
//카카오 로그인 인증 완료후, 사용자정보 요청
function kakaoRequest(){
  Kakao.API.request({
    url: '/v2/user/me',
    success: function(response) {
       console.log(response)
        console.log(response.id);
        console.log(response.properties.nickname);
        console.log(response.kakao_account.email);
        
        $.ajax({
            url: "/user/kakaoLogin",
            type: "post",
            contentType : "application/json; UTF-8",
            data: JSON.stringify({
               "userId" : response.id,
               "userNick" : response.properties.nickname,
               "userEmail" : response.kakao_account.email
            }),
            success: function(data) {
	             if(data !== "kakaoError"){
	              	alert("카카오 계정 로그인 성공");
	             	 location.href= "/notices/list";
	             }else if(data === "kakaoError"){
	            	 alert("카카오 계정 연동 실패");
	             }

            },
            error: function(error) {
                console.log("실패");
            }
       });
    
    
    },
    fail: function(error) {
        console.log(error);
    }
   });
}