<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd" 
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Simple Chat</title>
</head>
<body>

    <div>
        <button type="button" onclick="openSocket();">대화방 참여</button>
        <button type="button" onclick="closeSocket();">대회방 나가기</button>
    	<br/><br/><br/>
          <input type="text" id="sender" value="${sessionScope.id}" style="display: none;">   <!--  id: jstl 로 사용 -->
          <p>${id} 님과의 대화방입니다.<p>
  		메세지 입력 : 
        <input type="text" id="messageinput">
        <button type="button" onclick="send();">메세지 전송</button>
        <button type="button" onclick="javascript:clearText();">대화내용 지우기</button>
    </div>
    <!-- Server responses get written here -->
    <div id="messages">
    </div>
    
    회원 - 상담사연결! 
    
    
    <!-- websocket javascript -->
    <script type="text/javascript">
        var ws;
        var messages = document.getElementById("messages");
        
        //대화방참여 
        function openSocket(){
            if(ws !== undefined && ws.readyState !== WebSocket.CLOSED ){
                writeResponse("이미 대화방에 참여 중입니다.");
                return;
            }
            
            //웹소켓 객체 만드는 코드          //qclass.iptime.org  :포트도 톰켓 버전에 맞춰서 바꿔주기. (9.0에맞는거 쓰면 됨.)
            ws = new WebSocket("ws://localhost:8080/bnpp/echo.do");            //바꿔야 하나?
            		//localhost: me: 127.0.0.1  나한테 요청, 실제 아이피 주소가 바뀜. 
            		//dns. 
            
            
            ws.onopen = function(event){
                if(event.data === undefined){
              		return ;
                }
                //function writeResponse(text){    +된 내메세지 보여주기
                writeResponse(event.data);
            };
            
            ws.onmessage = function(event){ // 메시지를 받았을 때(
                console.log('writeResponse');
                console.log(event.data)
                writeResponse(event.data);
            };
            
            //  function closeSocket()
            ws.onclose = function(event){
                writeResponse("대화 종료");
            }
            
        }
        
        //메세지전송 
        function send(){
            var text = document.getElementById("messageinput").value+ "," +document.getElementById("sender").value; //메세지 
            ws.send(text);
            text = "";
        }
        //대화방 나가기 
        function closeSocket(){
            ws.close();
        }
        // 내가 메세지전송 후 이제까지 메세지 + 내메세지 보여주기 
        function writeResponse(text){
            messages.innerHTML += "<br/>"+text;
        }
        //대화내용 지우기 
        function clearText(){
            console.log(messages.parentNode);
            messages.parentNode.removeChild(messages)
      	}
        
  </script>
</body>
</html>