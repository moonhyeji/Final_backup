<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>공유주방 정보</h1>
지금 현재 나의 위치가 가장 먼저 표시됩니다.(chrom e에선 https 환경에서만 가능합니다.)<br>
공유주방의 정보를 지도에서 확인할 수 있습니다.  <br>
마커에 마우스를 올리면 타이틀이 표시됩니다.<br><br><br>
////////////////마커 클릭시 맵 밖에 주소 보이도록 하기 
<body>
<!-- 지도를 표시할 div 입니다 -->
<div id="map" style="width:50%; height:350px;"></div>
<!--  javascript -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c49d55de179096be77a889b0a969ef10"></script>
<script>


// div에 지도를 표시
var mapContainer = document.getElementById('map'),  
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // browser open시 지도가 처음에 표시될  중심좌표
        level: 3 // 지도의 확대 레벨
    };  
    
    
    
//지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption); 
    

		//지금 나의 위치 
		//HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
		if (navigator.geolocation) {
		 
		 // GeoLocation을 이용해서 접속 위치를 얻어옵니다
		 navigator.geolocation.getCurrentPosition(function(position) {
		     
			 var lat = position.coords.latitude, // 위도
		         lon = position.coords.longitude; // 경도
		     var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
		         message = '<div style="padding:5px;"> 나의 현재위치</div>'; // 인포윈도우에 표시될 내용입니다
		     
		         // 마커와 인포윈도우를 표시합니다
		     displayMarker(locPosition, message);
		   });
		//HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
		} else { 
		    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
		        message = 'geolocation을 사용할수 없어요..'
		    displayMarker(locPosition, message);
		}
		
		
		
		
		
		
		
		//-------------------geolocation으로 내위치를 지도에 마커와 인포윈도우를 표시하는 함수입니다
		function displayMarker(locPosition, message) {
		
		 // 마커를 생성합니다
		 var marker = new kakao.maps.Marker({  
		     map: map, 
		     position: locPosition
		 }); 
		 
		 var iwContent = message, // 인포윈도우에 표시할 내용
		     iwRemoveable = true;
		
		 // 인포윈도우를 생성합니다
		 //클릭하면 아래쪽에 작게 나타나는 인포윈도우 
		  var infowindow = new kakao.maps.InfoWindow({
		     content : iwContent,
		     removable : iwRemoveable
		 });		 
		 // 인포윈도우를 마커위에 표시합니다 
		 infowindow.open(map, marker);
		 
		 // 지도 중심좌표를 접속위치로 변경합니다
		 map.setCenter(locPosition);      
		}  
		//--------------------------------geolocation으로 내위치를 -지도에 마커와 인포윈도우를 표시하는 함수입니다
		
		
		
		
		
		var positions = [
	    {
	    	content: '<div style="padding:5px;">투썸 플레이스</div>',
	        latlng: new kakao.maps.LatLng(37.541284, 126.840278)
	    },
	    {
	    	content: '스타벅스 화곡',
	        latlng: new kakao.maps.LatLng(37.5405758,126.8356851)
	    },
	    {
	    	content: '카카오', 
	        latlng: new kakao.maps.LatLng(33.450705, 126.570677)
	    },
	    {
	    	content: '생태연못', 
	        latlng: new kakao.maps.LatLng(33.450936, 126.569477)
	    },
	    {
	    	content: '텃밭', 
	        latlng: new kakao.maps.LatLng(33.450879, 126.569940)
	    },
	    {
	    	content: '근린공원',
	        latlng: new kakao.maps.LatLng(33.451393, 126.570738)
	    }
	];
		

		
		
		
		for (var i = 0; i < positions.length; i ++) {
		    // 마커를 생성합니다
		    var marker = new kakao.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: positions[i].latlng // 마커의 위치
		    });

		    // 마커에 표시할 인포윈도우를 생성합니다 
		    var infowindow = new kakao.maps.InfoWindow({
		        content: positions[i].content // 인포윈도우에 표시할 내용
		    });

		    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
		    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
		    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
		    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
		    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
		}

		// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
		function makeOverListener(map, marker, infowindow) {
		    return function() {
		        infowindow.open(map, marker);
		    };
		}

		// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
		function makeOutListener(infowindow) {
		    return function() {
		        infowindow.close();
		    };
		}

		/* 
		var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		 //마커가 여러개일 경우, 포지션에 마커 표시하기 
		for (var i = 0; i < positions.length; i ++) {
		  // 마커 이미지의 이미지 크기 입니다
		  var imageSize = new kakao.maps.Size(24, 35); 
		  // 마커 이미지를 생성합니다    
		  var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		 
			  // 마커를 생성합니다
			  var marker = new kakao.maps.Marker({
			      map: map, // 마커를 표시할 지도
			      position: positions[i].latlng, // 마커를 표시할 위치
			      title : positions[i].title, // 마커의 타이틀,  마커에 마우스를 올리면 타이틀이 표시됩니다
			      image : markerImage // 마커 이미지 
			  });
			  

		} */
				// 마커에 커서가 오버됐을 때 마커 위에 표시할 인포윈도우를 생성합니다
				// 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
			//	var iwContent =  '<div style="padding:5px;">Hello World!</div>'; 


/* 
			// 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({
				for (var i = 0; i < positions.length; i ++) {
				content : position[i].title
				}
			});
			
 */
		
			
		
		
		
		
		 

		//-------------------------마우스 오버 아웃이벤트 ------------------
		//마커에 마우스오버 이벤트를 등록합니다
		kakao.maps.event.addListener(marker, 'mouseover', function() {
		// 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
		 infowindow.open(map, marker);
		});

		//마커에 마우스아웃 이벤트를 등록합니다
		kakao.maps.event.addListener(marker, 'mouseout', function() {
		 // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
		 infowindow.close();
		});
		 

		/* 

		//인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({
			    content : iwContent
			});

		// 마커를 지도에 표시합니다.
	//	marker.setMap(map);

 
//----------------------------------------------------------------마커리스트----------
//마커를 표시할 위치와 title 객체 배열입니다 
 var positions = [
	 
	    {
	    	iwContent: '<div style="padding:5px;">투썸 플레이스</div>'; 
	        latlng: new kakao.maps.LatLng(37.541284, 126.840278)
	    },
	    {
	    	iwContent: '카카오', 
	        latlng: new kakao.maps.LatLng(33.450705, 126.570677)
	    },
	    {
	    	iwContent: '생태연못', 
	        latlng: new kakao.maps.LatLng(33.450936, 126.569477)
	    },
	    {
	    	iwContent: '텃밭', 
	        latlng: new kakao.maps.LatLng(33.450879, 126.569940)
	    },
	    {
	    	iwContent: '근린공원',
	        latlng: new kakao.maps.LatLng(33.451393, 126.570738)
	    }
	];

		
		
		
//마커 이미지의 이미지 주소
var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
  
	 //마커가 여러개일 경우, 포지션에 마커 표시하기 
	for (var i = 0; i < positions.length; i ++) {
	  // 마커 이미지의 이미지 크기 입니다
	  var imageSize = new kakao.maps.Size(24, 35); 
	  // 마커 이미지를 생성합니다    
	  var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
	 
		  // 마커를 생성합니다
		  var marker = new kakao.maps.Marker({
		      map: map, // 마커를 표시할 지도
		      position: positions[i].latlng, // 마커를 표시할 위치
		      //title : positions[i].title, // 마커의 타이틀,  마커에 마우스를 올리면 타이틀이 표시됩니다
		      iwContent : positions[i].iwContent,
		      image : markerImage // 마커 이미지 
		      

		      
		  });
		  
	} 
  
  
//-------------------------마우스 오버 아웃이벤트 ------------------
//마커에 마우스오버 이벤트를 등록합니다
kakao.maps.event.addListener(marker, 'mouseover', function() {
// 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
 infowindow.open(map, marker);
});

//마커에 마우스아웃 이벤트를 등록합니다
kakao.maps.event.addListener(marker, 'mouseout', function() {
 // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
 infowindow.close();
});
   */
</script>

</body>
</html>