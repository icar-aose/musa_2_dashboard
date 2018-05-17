<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<meta http-equiv="content-type" content="text/html;charset=UTF-8" />
<head>
    <title>MUSA Goal Editor</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" type="text/css" href="../../build/rappid.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/theme-picker.css">

    <!-- theme-specific application CSS  -->
    <link rel="stylesheet" type="text/css" href="css/style.dark.css">
    <link rel="stylesheet" type="text/css" href="css/style.material.css">
    <link rel="stylesheet" type="text/css" href="css/style.modern.css">
</head>
<body onbeforeunload="return myFunction()">
<script>
function myFunction() {
	if(confUscita===true){
    return "Do you want to exit? Unsaved changes will be lost.";}
}
</script>

    <div id="app">
        <div class="app-header">
              <div class="app-title">
                  <h1>MUSA Goal Editor</h1>
              </div>
              <div class="toolbar-container"></div>
        </div>
        <div class="app-body">
              <div class="stencil-container"></div>
              <div class="paper-container"></div>
              <div class="inspector-container"></div>
              <div class="navigator-container"></div>
        </div>
    </div>

    <!-- Rappid/JointJS dependencies: -->
    <script src="../../node_modules/jquery/dist/jquery.js"></script>
    <script src="../../node_modules/lodash/index.js"></script>
    <script src="../../node_modules/backbone/backbone.js"></script>
    <script src="../../node_modules/graphlib/dist/graphlib.core.js"></script>
    <script src="../../node_modules/dagre/dist/dagre.core.js"></script>

    <script src="../../build/rappid.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link href="../../../../css/jquery-ui.css" rel="stylesheet" type="text/css" media="all" />
    
    <!--[if IE 9]>
        <script>
          // `-ms-user-select: none` doesn't work in IE9
          document.onselectstart = function() { return false; };
        </script>
    <![endif]-->

    <!-- Application files:  -->
    <script src="js/config/halo.js"></script>
    <script src="js/config/selection.js"></script>
    <script src="js/config/inspector.js"></script>
    <script src="js/config/stencil.js"></script>
    <script src="js/config/toolbar.js"></script>
    <script src="js/config/sample-graphs.js"></script>
    <script src="js/views/main.js"></script>
    <script src="js/views/theme-picker.js"></script>
    <script src="js/models/joint.shapes.app.js"></script>
	<script type="text/javascript" src="js/config/FileSaver.js"></script>

<!--  Form che contiene i dati del grafico che verranno memorizzati su DB -->	
	<s:form id="formtosub" action="saveGoalJson" namespace="/customer" method="post">

		<s:hidden id="idSpecification" name="idSpecification" value="%{#parameters.idSpecification}" />
		<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />

		<s:hidden id="supportContent" name="supportContent" />
		<s:hidden id="graphName" name="graphName" />
		<s:hidden id="flagSaveElements" name="flagSaveElements" />
		
		<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
		<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
	
  	</s:form>
  	
    <s:url id="listFunc" action="listFunctionalReq" var="listF" escapeAmp="false">
      <s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
      <s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
    </s:url>
    
    <script>
        joint.setTheme('material');
        app = new App.MainView({ el: '#app' });
        themePicker = new App.ThemePicker({ mainView: app });
        themePicker.render().$el.appendTo(document.body);

        var parser = new DOMParser;
        window.addEventListener('load', function() {
            var content ='<s:property value="jsonContent" />';
            var dom = parser.parseFromString(content, "text/html");
            if(content!=''){
            app.graph.fromJSON(JSON.parse(dom.body.textContent));
            }
        });

		$('#goalname').val($('#graphName').val());

		var listFunc='<s:property value="#listF" />';
		dom = parser.parseFromString(listFunc, "text/html");
		listFunc=dom.body.textContent;
		var confUscita=true;
    </script>


<!-- Dialog per l'inserimento di goal presenti su DB -->
	<script>
	$( function() {
		 var goalJson =parser.parseFromString('<s:property value="jsonGoalList" />', "text/html").body.textContent;
		 var goalList=JSON.parse(goalJson);

		 
		var dialog,dialog2;
		dialog=$( "#goaldg" ).dialog({
	    resizable: false,
	    height: "auto",
	    width: "auto",
	    modal: true,
	    autoOpen:false,
	    buttons: {
	      "Insert": function() {
		      
			      	var ind=$("#idGoal").prop("selectedIndex");
			      	if(ind!= -1){

			    	    var listaCelle=app.graph.getCells();
			    		for (let cella of listaCelle){
			    			var type=cella.attributes.type;
			    			if(type==="erd.Goal"){			
			    				if(cella.attributes.attrs[".idDB"].text===goalList[ind].idFunctionalReq){
				    				alert("Goal already inserted in Graph");
			    					return
			    				}	
			    			}
			    		}
		    	 		$( this ).dialog( "close" );
			    		
				        var goal = new joint.shapes.erd.Goal({
				            size: { width: 120, height: 48 },
				            position: { x: 500, y: 500 },
				            attrs: {
					            'text': { text: goalList[ind].name},
					            '.actors': { text: goalList[ind].actors},
					            '.priority': { text: goalList[ind].priority},
					            '.description': { text: goalList[ind].description},
					            '.body': { text: goalList[ind].body},
					            '.idDB': { text: goalList[ind].idFunctionalReq}
				            }
			        	});
			        	goal.removeAttr('./data-tooltip');
			        	
				        app.graph.addCells([goal]);  
					}

	      },
	      Cancel: function() {
	        $( this ).dialog( "close" );
	      }
	    }
	  });


	
	});
	</script> 
 
	<div id="goaldg" title="Select Functional Requirement to Insert">
		<s:select
		id="idGoal"
		name="idGoal"
		label="Functional Requirement"
		list="functionalReqList"
		listKey="idFunctionalReq"
		listValue="name"/>
	</div>
</body>

<!-- Dialog per l'inserimento di quality requirements presenti su DB -->
	<script>
	 var qualityJson =parser.parseFromString('<s:property value="jsonQualityList" />', "text/html").body.textContent;
	 var qualityList=JSON.parse(qualityJson);
	  	 
	var dialog2;
	$( function() {
		dialog2=$( "#qualitydg" ).dialog({
	    resizable: false,
	    height: "auto",
	    width: "auto",
	    modal: true,
	    autoOpen:false,
	    buttons: {
	      "Insert": function() {
			      	var ind=$("#idQuality").prop("selectedIndex");
			      	if(ind!= -1){


			    	    var listaCelle=app.graph.getCells();
			    		for (let cella of listaCelle){
			    			var type=cella.attributes.type;
			    			if(type==="basic.Quality"){			
			    				if(cella.attributes.attrs[".idDB"].text===qualityList[ind].idNonFunctionalReq){
				    				alert("Quality already inserted in Graph");
			    					return
			    				}	
			    			}
			    		}
		    	 		$( this ).dialog( "close" );
		    	 		
				        var quality = new joint.shapes.basic.Quality({
				            size: { width: 130, height: 75 },
				            position: { x: 500, y: 500 },
				            attrs: {
					            text: { text: qualityList[ind].name},
					            '.description': { text: qualityList[ind].description},
					            '.body': { text: qualityList[ind].value},
					            '.idDB': { text: qualityList[ind].idNonFunctionalReq}
				            }
			        	});
			        	quality.removeAttr('./data-tooltip');
				        app.graph.addCells([quality]);  
					}

	      },
	      Cancel: function() {
	        $( this ).dialog( "close" );
	      }
	    }
	  });
		  
	});

	
	$(window).resize(function() {
	    $("#qualitydg").dialog("option", "position", {my: "center", at: "center", of: window});
		$("#goaldg").dialog("option", "position", {my: "center", at: "center", of: window});
	});
	</script> 
 
	<div id="qualitydg" title="Select Quality Requirement to Insert">
		<s:select
		id="idQuality"
		name="idQuality"
		label="Quality Requirement"
		list="nonFunctionalReqList"
		listKey="idNonFunctionalReq"
		listValue="name"/>
	</div>
</body>
</html>
