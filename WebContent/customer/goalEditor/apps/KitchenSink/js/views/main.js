var App = window.App || {};
var inspector;
(function(_, joint) {

    'use strict';
    App.MainView = joint.mvc.View.extend({

        className: 'app',

        events: {
            'focus input[type="range"]': 'removeTargetFocus',
            'mousedown': 'removeFocus',
            'touchstart': 'removeFocus'
        },

        removeTargetFocus: function(evt) {
            evt.target.blur();
        },

        removeFocus: function() {
            document.activeElement.blur();
            window.getSelection().removeAllRanges();
        },

        init: function() {

            this.initializePaper();
            this.initializeStencil();
            this.initializeSelection();
            this.initializeHaloAndInspector();
            this.initializeNavigator();
            this.initializeToolbar();
            this.initializeKeyboardShortcuts();
            this.initializeTooltips();
			this.initializeValidator();
        },

        // Create a graph, paper and wrap the paper in a PaperScroller.
        initializePaper: function() {

            var graph = this.graph = new joint.dia.Graph;
            /*
            graph.on('add', function(cell, collection, opt) {
                if (opt.stencil) inspector=this.createInspector(cell);
    			this.paper.on('blank:pointerclick', function(){
    				inspector.remove();
    			});
            }, this);*/


			this.graph.on('remove', function(){	
			    var celle=app.graph.getCells();
			    for(let cella of celle){
			    	if(cella.attributes.type==="erd.Relationship"){
			    		var inl=app.graph.getConnectedLinks(cella,{ inbound: true }).length;
			    		if(inl===0){
			    			cella.remove();
			    		}
			    	}
			    }
			});
			
            this.commandManager = new joint.dia.CommandManager({ graph: graph });
            this.validator = new joint.dia.Validator({ commandManager: this.commandManager });
			
            var paper = this.paper = new joint.dia.Paper({
                width: 1000,
                height: 1000,
                gridSize: 13,
                drawGrid: {
                    name: 'mesh',
                    args: [
                        { color: '#cacaca', thickness: 0.5 }
                ]},
                model: graph,
				linkPinning: false,
                defaultLink: new joint.shapes.app.Link,

				/*interactive: function(cellView) {
					if (cellView.model instanceof joint.dia.Link) {
						// Disable the default vertex add functionality on pointerdown.
						return { vertexAdd: false };
					}
					return true;
				}*/
			
            });
						
            paper.on('blank:mousewheel', _.partial(this.onMousewheel, null), this);
            paper.on('cell:mousewheel', this.onMousewheel, this);
            this.snaplines = new joint.ui.Snaplines({ paper: paper });

            var paperScroller = this.paperScroller = new joint.ui.PaperScroller({
                paper: paper,
                autoResizePaper: true,
                cursor: 'grab'
            });

            this.$('.paper-container').append(paperScroller.el);
            paperScroller.render().center();
        },

        // Create and populate stencil.
        initializeStencil: function() {

            var stencil = this.stencil = new joint.ui.Stencil({
                paper: this.paperScroller,
                snaplines: this.snaplines,
                scaleClones: true,
                width: 240,
                groups: App.config.stencil.groups,
                dropAnimation: true,
                groupsToggleButtons: true,
                /*search: {
                    '*': ['type', 'attrs/text/text', 'attrs/.label/text'],
                    'org.Member': ['attrs/.rank/text', 'attrs/.name/text']
                },*/
                // Use default Grid Layout
                layout: true,
                // Remove tooltip definition from clone
                dragEndClone: function(cell) {
                    return cell.clone().removeAttr('./data-tooltip');
                }
            });

            this.$('.stencil-container').append(stencil.el);
            stencil.render().load(App.config.stencil.shapes);
            
			this.$('.joint-stencil').append('<div class="groups-toggle"><label class="group-label">Goal Model Name</label></div><div class="search-wrap"><input id="goalname" type="text" placeholder="Goal Model Name" class="text"></div><div class="stencil-paper-drag joint-paper joint-theme-'+joint.mvc.View.prototype.defaultTheme+'" style="width: 1px; height: 1px;"><div class="joint-paper-background"></div><div class="joint-paper-grid"></div><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="v-16" width="100%" height="100%"><g id="v-17" class="joint-viewport"></g><defs id="v-18"></defs></svg></div>');
        
        },

        initializeKeyboardShortcuts: function() {

            this.keyboard = new joint.ui.Keyboard();
            this.keyboard.on({

                'ctrl+c': function() {
                    // Copy all selected elements and their associated links.
                    this.clipboard.copyElements(this.selection.collection, this.graph);
                },

                'ctrl+v': function() {

                    var pastedCells = this.clipboard.pasteCells(this.graph, {
                        translate: { dx: 20, dy: 20 },
                        useLocalStorage: true
                    });
                    
                    var i;
                    for (i = 0; i < pastedCells.length; i++) { 
                    	pastedCells[i].removeAttr('.idDB');
                    }
                    var elements = _.filter(pastedCells, function(cell) {
                        return cell.isElement();
                    });

                    // Make sure pasted elements get selected immediately. This makes the UX better as
                    // the user can immediately manipulate the pasted elements.
                    this.selection.collection.reset(elements);
                },

                'ctrl+x shift+delete': function() {
                    this.clipboard.cutElements(this.selection.collection, this.graph);
                },

                'delete backspace': function(evt) {
                    evt.preventDefault();
                    this.graph.removeCells(this.selection.collection.toArray());
                },

                'ctrl+z': function() {
                    this.commandManager.undo();
                    this.selection.cancelSelection();
                    
                },

                'ctrl+y': function() {
                    this.commandManager.redo();
                    this.selection.cancelSelection();
                },

                'ctrl+a': function() {
                    this.selection.collection.reset(this.graph.getElements());
                },

                'ctrl+plus': function(evt) {
                    evt.preventDefault();
                    this.paperScroller.zoom(0.2, { max: 5, grid: 0.2 });
                },

                'ctrl+minus': function(evt) {
                    evt.preventDefault();
                    this.paperScroller.zoom(-0.2, { min: 0.2, grid: 0.2 });
                },

                'keydown:shift': function(evt) {
                    this.paperScroller.setCursor('crosshair');
                },

                'keyup:shift': function() {
                    this.paperScroller.setCursor('grab');
                }

            }, this);
        },

        initializeSelection: function() {

            this.clipboard = new joint.ui.Clipboard();
            this.selection = new joint.ui.Selection({
                paper: this.paper,
                handles: App.config.selection.handles
            });

            // Initiate selecting when the user grabs the blank area of the paper while the Shift key is pressed.
            // Otherwise, initiate paper pan.
            this.paper.on('blank:pointerdown', function(evt, x, y) {

                if (this.keyboard.isActive('shift', evt)) {
                    this.selection.startSelecting(evt);
                } else {
                    this.selection.cancelSelection();
                    this.paperScroller.startPanning(evt, x, y);
                }

            }, this);

            this.paper.on('element:pointerdown', function(elementView, evt) {

                // Select an element if CTRL/Meta key is pressed while the element is clicked.
                if (this.keyboard.isActive('ctrl meta', evt)) {
                    this.selection.collection.add(elementView.model);
                }

            }, this);

            this.selection.on('selection-box:pointerdown', function(elementView, evt) {

                // Unselect an element if the CTRL/Meta key is pressed while a selected element is clicked.
                if (this.keyboard.isActive('ctrl meta', evt)) {
                    this.selection.collection.remove(elementView.model);
                }

            }, this);
        },

        createInspector: function(cell) {
        	if (cell.attributes.type==="app.Link"){
        		if(cell.attributes[".relat"]===undefined){return null}
        	}
            return joint.ui.Inspector.create('.inspector-container', _.extend({
                cell: cell
            }, App.config.inspector[cell.get('type')]));
        },

        initializeHaloAndInspector: function() {

            this.paper.on('element:pointerup link:options', function(cellView) {

                var cell = cellView.model;

                if (!this.selection.collection.contains(cell)) {

                    if (cell.isElement()) {

                        new joint.ui.FreeTransform({
                            cellView: cellView,
                            allowRotation: false,
                            preserveAspectRatio: !!cell.get('preserveAspectRatio'),
                            allowOrthogonalResize: cell.get('allowOrthogonalResize') !== false
                        }).render();

                        var currentHalo=new joint.ui.Halo({
                            cellView: cellView,
                            handles: App.config.halo.handles
                        }).render();
						if(cell.attributes.type=="erd.Relationship"){
							currentHalo.removeHandle('fork');
							currentHalo.removeHandle('clone');
							currentHalo.removeHandle('rotate');								
						}		
						else{
						currentHalo.removeHandle('fork');
						currentHalo.removeHandle('clone');
						currentHalo.removeHandle('rotate');	
						currentHalo.removeHandle('link');	
						currentHalo.addHandle({
							name: 'and',
							position: 'n',
							icon: './assets/and.png',
							events: { pointerdown: 'startAnding', pointermove: 'doFork', pointerup: 'stopForking' },
							attrs: {
								'.handle': {
									'data-tooltip-class-name': 'small',
									'data-tooltip': 'Click and drag to connect the object with an AND relationship',
									'data-tooltip-position': 'left',
									'data-tooltip-padding': 15
								}
							}							
							});
							
						currentHalo.addHandle({
							name: 'or',
							position: 'ne',
							icon: './assets/or.png',
							events: { pointerdown: 'startOring', pointermove: 'doFork', pointerup: 'stopForking' },
							attrs: {
								'.handle': {
									'data-tooltip-class-name': 'small',
									'data-tooltip': 'Click and drag to connect the object with an OR relationship',
									'data-tooltip-position': 'left',
									'data-tooltip-padding': 15
								}
							}
							
							});
						currentHalo.addHandle({
							name: 'impact',
							position: 's',
							icon: './assets/impact.png',
							events: { pointerdown: 'startImpacting', pointermove: 'doLink', pointerup: 'stopLinking' },
							attrs: {
								'.handle': {
									'data-tooltip-class-name': 'small',
									'data-tooltip': 'Click and drag to connect the object with an IMPACT relationship',
									'data-tooltip-position': 'left',
									'data-tooltip-padding': 15
								}
							}
							
							});	
						currentHalo.addHandle({
							name: 'conflict',
							position: 'se',
							icon: './assets/conflict.png',
							events: { pointerdown: 'startConflicting', pointermove: 'doLink', pointerup: 'stopLinking' },
							attrs: {
								'.handle': {
									'data-tooltip-class-name': 'small',
									'data-tooltip': 'Click and drag to connect the object with a CONFLICT relationship',
									'data-tooltip-position': 'left',
									'data-tooltip-padding': 15
								}
							}
							
							});								
						}
                        this.selection.collection.reset([]);
                        this.selection.collection.add(cell, { silent: true });
                    }

                    inspector=this.createInspector(cell);              
				
				}	
            }, this);
        },

        initializeNavigator: function() {

            var navigator = this.navigator = new joint.ui.Navigator({
                width: 240,
                height: 115,
                paperScroller: this.paperScroller,
                zoom: false
            });

            this.$('.navigator-container').append(navigator.el);
            navigator.render();
        },

        initializeToolbar: function() {

            var toolbar = this.toolbar = new joint.ui.Toolbar({
                groups: App.config.toolbar.groups,
                tools: App.config.toolbar.tools,
                references: {
                    paperScroller: this.paperScroller,
                    commandManager: this.commandManager
                }
            });
            
            toolbar.on({
                'svg:pointerclick': _.bind(this.openAsSVG, this),
                'png:pointerclick': _.bind(this.openAsPNG, this),			
				'exp_json:pointerclick': _.bind(this.saveJSON, this),
				'imp_json:pointerclick': _.bind(this.loadJSON, this),
				'saveDB:pointerclick': _.bind(this.saveToDB, this),
				'saveElementsDB:pointerclick': _.bind(this.saveElementsDB, this),
				'selectExport:close': _.bind(this.selectExport, this),
				'selectSave:close': _.bind(this.selectSave, this),
				'insertGoal:pointerclick': _.bind(this.insertGoal, this),
				'selectInsert:close': _.bind(this.selectInsert, this),
				'insertQuality:pointerclick': _.bind(this.insertQuality, this),	
                'to-front:pointerclick': _.bind(this.selection.collection.invoke, this.selection.collection, 'toFront'),
                'to-back:pointerclick': _.bind(this.selection.collection.invoke, this.selection.collection, 'toBack'),
                'layout:pointerclick': _.bind(this.layoutDirectedGraph, this),
                /*'snapline:change': _.bind(this.changeSnapLines, this),*/
                'clear:pointerclick': _.bind(this.graph.clear, this.graph),
                'print:pointerclick': _.bind(this.paper.print, this.paper)
                /*'grid-size:change': _.bind(this.paper.setGridSize, this.paper)*/
            });

            this.$('.toolbar-container').append(toolbar.el);
			this.$('.toolbar-container').append('<input class="menu-item" type="file" id="fileLoader" name="files" style="display:none" />');

            toolbar.render();
            window.tb=toolbar.widgets;
            
            for (var i = 0; i < window.tb.length; i++) {
                if (window.tb[i]["id"] === "selectExportId") {
                	window.tb.exp= window.tb[i].selectBox;
                }
                if (window.tb[i]["id"] === "selectSaveId") {
                	window.tb.save= window.tb[i].selectBox;
                }
                if (window.tb[i]["id"] === "selectInsertId") {
                	window.tb.insert= window.tb[i].selectBox;
                }
            }
            return null;
        },

        changeSnapLines: function(checked) {

            if (checked) {
                this.snaplines.startListening();
                this.stencil.options.snaplines = this.snaplines;
            } else {
                this.snaplines.stopListening();
                this.stencil.options.snaplines = null;
            }
        },
        
        selectExport: function(checked) {
        	var ind=window.tb.exp.getSelection();
        	if(ind!=undefined){
        		switch(ind.value){
        		case 1: 
        			this.openAsPNG();
            		window.tb.exp.select(-1);
        			break;
        		case 2: 
        			this.openAsSVG();
            		window.tb.exp.select(-1);
        			break;
        		case 3: 
        			this.saveJSON();
            		window.tb.exp.select(-1);
        			break;
        		case 4: 
        			this.loadJSON();
            		window.tb.exp.select(-1);
        			break;

        		}
        	}
        },        

        selectSave: function(checked) {
        	var ind=window.tb.save.getSelection();
        	if(ind!=undefined){
        		switch(ind.value){
        		case 1: 
        			this.saveToDB();
            		window.tb.save.select(-1);
        			break;
        		case 2: 
        			this.saveElementsDB();
            		window.tb.save.select(-1);
        			break;

        		}
        	}
        }, 
        
        selectInsert: function(checked) {
        	var ind=window.tb.insert.getSelection();
        	if(ind!=undefined){
        		switch(ind.value){
        		case 1: 
        			this.insertGoal();
            		window.tb.insert.select(-1);
        			break;
        		case 2: 
        			this.insertQuality();
            		window.tb.insert.select(-1);
        			break;

        		}
        	}
        },  
        
        initializeTooltips: function() {

            new joint.ui.Tooltip({
                rootTarget: document.body,
                target: '[data-tooltip]',
                direction: 'auto',
                padding: 10
            });
        },

        exportStylesheet: [
            '.scalable * { vector-effect: non-scaling-stroke }',
            '.marker-arrowheads { display:none }',
            '.marker-vertices { display:none }',
            '.link-tools { display:none }'
        ].join(''),

        openAsSVG: function() {

            this.paper.toSVG(function(svg) {
                new joint.ui.Lightbox({
                    title: '(Right-click, and use "Save As" to save the diagram in SVG format)',
                    image: 'data:image/svg+xml,' + encodeURIComponent(svg)
                }).open();
            }, {
                preserveDimensions: true,
                convertImagesToDataUris: true,
                useComputedStyles: false,
                stylesheet: this.exportStylesheet
            });
        },

		saveJSON: function() {
			popolaRelazioni();
			var textFileAsBlob = new Blob([JSON.stringify(this.graph.toJSON())], {type:'text/plain'});
			saveAs(textFileAsBlob, "fileJSON");
		},
		
		saveToDB: function() {
			$('#flagSaveElements').val("false");
			$('#graphName').val($('#goalname').val());
			$('#supportContent').val(JSON.stringify(this.graph.toJSON()));
			confUscita=false;
			$('#formtosub').submit();
		},
		
		saveElementsDB: function() {
			$('#flagSaveElements').val("true");
			$('#graphName').val($('#goalname').val());

		    var listaCelle=app.graph.getCells();
		    var datiMancanti=new Array();
		    for(let cella of listaCelle){
		    	if(cella.attributes.type==="erd.Relationship"){
		    		var inl=app.graph.getConnectedLinks(cella,{ outbound: true }).length;
		    		if(inl<1){
		    			alert("There are unlinked Relations, cannot save to DB.");
		    			return;
		    		}
		    	}	    	
		    	if(cella.attributes.type==="erd.Goal"){
		    		var goalAttrs=cella.attributes.attrs;
		    		if(goalAttrs['text']!=undefined){
		    			if(goalAttrs['text'].text===''){datiMancanti.push(goalAttrs);break}
		    		}
		    		if(goalAttrs['.body']!=undefined){
		    			if(goalAttrs['.body'].text===''){datiMancanti.push(goalAttrs);break}
		    		}
		    		if(goalAttrs['.actors']!=undefined){
		    			if(goalAttrs['.actors'].text===''){datiMancanti.push(goalAttrs);break}
		    		}
		    	}
		    	
		    	if(cella.attributes.type==="basic.Quality"){
		    		var qualityAttrs=cella.attributes.attrs;
		    		if(qualityAttrs['text']!=undefined){
		    			if(qualityAttrs['text'].text===''){datiMancanti.push(qualityAttrs);break}
		    		}
		    		if(qualityAttrs['.body']!=undefined){
		    			if(qualityAttrs['.body'].text===''){datiMancanti.push(qualityAttrs);break}
		    		}	    		
		    	}		    	
		    	
		    }
		    if (datiMancanti.length>0){alert("There are "+datiMancanti.length+" cells not filled corretly.");return}
			popolaRelazioni();
			$('#supportContent').val(JSON.stringify(this.graph.toJSON()));		
			confUscita=false;
			$('#formtosub').submit();
		},
		
		insertGoal: function() {
			$("#goaldg").dialog("open");
		},		

		insertQuality: function() {
			$("#qualitydg").dialog("open");
		},	
		
		loadJSON: function() {
			
			$("#fileLoader").click();		
			
			var fileInput = document.getElementById("fileLoader");
			fileInput.addEventListener("click", function(event) {
				this.value=null;
			});
			
			fileInput.addEventListener("change", function(event) {	
			var files = event.target.files;
			var file = files[0];
			var picReader = new FileReader();
			
				picReader.addEventListener("load", function(event) {
						var textFile = event.target;
						var div = document.createElement("div");
						app.graph.fromJSON(JSON.parse(textFile.result));
						$("#fileLoader").value=null;
				});
				
			picReader.readAsText(file);
			});
			
		},		
		
        openAsPNG: function() {

            this.paper.toPNG(function(dataURL) {
                new joint.ui.Lightbox({
                    title: '(Right-click, and use "Save As" to save the diagram in PNG format)',
                    image: dataURL
                }).open();
            }, {
                padding: 10,
                useComputedStyles: false,
                stylesheet: this.exportStylesheet
            });
        },

        onMousewheel: function(cellView, evt, x, y, delta) {

            if (this.keyboard.isActive('alt', evt)) {
                evt.preventDefault();
                this.paperScroller.zoom(delta * 0.2, { min: 0.2, max: 5, grid: 0.2, ox: x, oy: y });
            }
        },

        layoutDirectedGraph: function() {

            joint.layout.DirectedGraph.layout(this.graph, {
                setLinkVertices: true,
                rankDir: 'TB',
                marginX: 100,
                marginY: 100
            });

            this.paperScroller.centerContent();
        },
		
		initializeValidator:function(){

            this.validator.validate('change:target',
                function (err, command, next) {
            	var gg=app.graph.toGraphLib();
                    if (command.data.type === 'app.Link') {
                        var link= command.data.attributes || app.graph.getCell(command.data.id).toJSON();
                        var sourceId = link.source.id;
                        var targetId = link.target.id;
			        	var inout=sourceId+"__"+targetId;
						var sourceType=app.graph.getCell(sourceId).attributes.type;
                        var targetType=app.graph.getCell(targetId).attributes.type;
                        var collegamentiRel=ottieniLinks();
                        console	
                        if (graphlib.alg.isAcyclic(gg)===false) {
							console.log("Loops are not allowed");
                            return next('Loops are not allowed');
                        }
                        
                        if (targetType ==="erd.Relationship") {
							console.log("Cannot connect Relationships");
                            return next('Cannot connect Relationships');
                        }
                        
			        	if(getOccurrence(collegamentiRel,inout)>1){
			        		console.log("Start and End already connected");
                            return next("Start and End already connected");
			        	}
                        
                        if ((sourceType ==="erd.Relationship") && (sourceType!=targetType)) {
                        	console.log("tentativo di connessione ad un goal/softgoal da una relazione");
                        	var relazioni=popolaRelazioni();
                        	var cellRelation=app.graph.getCell(sourceId);
                        	var origineRel=relazioni.get(sourceId).inRel[0];
                        	var inType=app.graph.getCell(origineRel).attributes.type;
				        	var inoutRel=origineRel+"__"+targetId;
                        	if(inType!=targetType){
								console.log("Cannot connect different objects");
	                            return next('Cannot connect different objects');
                        	}

                        	//Controllo relazioni AND & OR, per evitare che abbia luogo quando sono presenti 
                        	//Altre relazioni, sia AND / OR che impact/conflict
							if(inType===targetType){
								console.log("Test Collegamento Relazione");
					        	if(collegamentiRel.includes(inoutRel)){
					        		console.log("Start and End already connected");
		                            return next("Start and End already connected");
					        	}

								for (const key of relazioni.keys()) {
							        if(key!=sourceId){
							        	if((relazioni.get(key).inRel.includes(origineRel)&&relazioni.get(key).outRel.includes(targetId))){
							        		console.log("AND OR Relation already exists");
				                            return next("AND OR Relation already exists");
							        	}
							        }
								}
							}
                        }
                        //Fine controllo
                        
                        if ((sourceType !="erd.Relationship")) {
                        	if(!link.hasOwnProperty(".relat")){
								console.log("ERROR");
	                            return next("ERROR");
                        	}
                        	var relazioni=popolaRelazioni();
				        	var inoutRel=sourceId+"__"+targetId;
				        	
							for (const key of relazioni.keys()) {
						        if(key!=sourceId){
						        	if((relazioni.get(key).inRel.includes(sourceId)&&relazioni.get(key).outRel.includes(targetId))){
						        		console.log("AND OR Relation already exists");
			                            return next("AND OR Relation already exists");
						        	}
						        }
							}
                        }
                    }
                    return next();
                }
            );
            
            this.validator.validate('change:source',
                    function (err, command, next) {
                        if (command.data.type === 'app.Link') {
                            var link = command.data.attributes || app.graph.getCell(command.data.id).toJSON();

                            var sourceId = link.source.id;
                            var targetId = link.target.id;
                            
    						var sourceType=app.graph.getCell(sourceId).attributes.type;
                            var targetType=app.graph.getCell(targetId).attributes.type;   
                            console.log(sourceType);
                            console.log(targetType);
                            console.log(!_.isEqual(targetType,"erd.Relationship") && !_.isEqual(sourceType !="erd.Relationship"));
                            if (graphlib.alg.isAcyclic(gg)===false) {
    							console.log("Loops are not allowed");
                                return next('Loops are not allowed');
                            }

                            if (!_.isEqual(targetType,"erd.Relationship") && !_.isEqual(sourceType !="erd.Relationship")) {
    							console.log("Cannot change relationship source");
                                return next("Cannot change relationship source");
                            }
                            
                            if (targetType ==="erd.Relationship") {
    							console.log("Cannot change relationship source");
                                return next("Cannot change relationship source");
                            }  
                            if ((sourceType ==="erd.Relationship")&&(link.hasOwnProperty(".relat"))) {
    							console.log("Cannot connect impact/conflict link to relation");
                                return next("Cannot connect impact/conflict link to relation");
                            }                            
                            
                        }
                        return next();
                    }
                );            
		}
    });

})(_, joint);

function popolaRelazioni(){
	var relazioni = new Map();
    var listaCelle=app.graph.getCells();
    var graphLibVar=app.graph.toGraphLib()
	for (let cella of listaCelle){
		var type=cella.attributes.type;
		if(type==="erd.Relationship"){
			var arrIn=(graphLibVar.inEdges(cella.id)).map(function(a) {return a.v;});
			var arrOut=(graphLibVar.outEdges(cella.id)).map(function(a) {return a.w;});				
			cella.attr("outLinks",arrOut);
			cella.attr("inLinks",arrIn);
			var inout={inRel:arrIn,outRel:arrOut};
			relazioni.set(cella.id,inout);
		}
	};
	return relazioni
};

function ottieniLinks(){
	var links = new Array();
    var listaLink=app.graph.getLinks();
	for (let cella of listaLink){
			var inout=cella.attributes.source.id+"__"+cella.attributes.target.id;
			links.push(inout);
	};
	return links
};

function getOccurrence(array, value) {
    return array.filter((v) => (v === value)).length;
}