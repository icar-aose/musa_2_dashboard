<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<meta http-equiv="content-type" content="text/html;charset=UTF-8" />
<head>
    <meta charset="utf-8">
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
<body>

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
	
	<s:form id="formtosub" action="saveGoalJson" namespace="/customer" method="post">

		<s:hidden id="idSpecification" name="idSpecification" value="%{#parameters.idSpecification}" />
		<s:hidden id="idDomain" name="idDomain" value="%{#parameters.idDomain}" />

		<s:hidden id="supportContent" name="supportContent" />
		<s:hidden id="graphName" name="graphName" />
		
		<s:param name="idSpecification" value="%{#parameters.idSpecification}"></s:param>
		<s:param name="idDomain" value="%{#parameters.idDomain}"></s:param>
	
  	</s:form>
  		 
    <script>
    	var urlSaveDB='<s:property value="#urlSaveDB" />';
        joint.setTheme('material');
        app = new App.MainView({ el: '#app' });
        themePicker = new App.ThemePicker({ mainView: app });
        themePicker.render().$el.appendTo(document.body);

        
        window.addEventListener('load', function() {
            var content ='<s:property value="jsonContent" />';
            var parser = new DOMParser;
            var dom = parser.parseFromString(content, "text/html");
            if((content!=null)|| !(content.equals("")) ){
            app.graph.fromJSON(JSON.parse(dom.body.textContent));
            }
        });

		$('#goalname').val($('#graphName').val());
    </script>

</body>

</html>
