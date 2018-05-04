var App = window.App || {};
var inspector;
var azione;
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
        },

        // Create a graph, paper and wrap the paper in a PaperScroller.
        initializePaper: function() {

            var graph = this.graph = new joint.dia.Graph;

            graph.on('add', function(cell, collection, opt) {
                if (opt.stencil) inspector=this.createInspector(cell);
    			this.paper.on('blank:pointerclick', function(){
    				inspector.remove();
    			});
            }, this);


			
            this.commandManager = new joint.dia.CommandManager({ graph: graph });

            var paper = this.paper = new joint.dia.Paper({
                width: 1000,
                height: 1000,
                gridSize: 10,
                drawGrid: true,
                model: graph,
				linkPinning: false,
                defaultLink: new joint.shapes.app.Link,
/*
				interactive: function(cellView) {
					if (cellView.model instanceof joint.dia.Link) {
						// Disable the default vertex add functionality on pointerdown.
						return { vertexAdd: false };
					}
					return true;
				},
			
*/
				//controllo validità connessione
				validateConnection: function(cellViewS, magnetS, cellViewT, magnetT, end, linkView) {
				var source = cellViewS.model.get('type');
				var target = cellViewT.model.get('type');
				return ((source === 'basic.Quality')&&(target === 'erd.Goal')) || 
				((source === 'erd.Goal')&&(target === 'basic.Quality')) || 
				((source === 'erd.Goal')&&(target === 'erd.Relationship')) || 
				((source === 'basic.Quality')&&(target === 'erd.Relationship')) || 
				((source === 'basic.Quality')&&(target === 'erd.Goal')) || 				
				((source === 'erd.Relationship')&&(target === 'basic.Quality')) || 
				((source === 'erd.Relationship')&&(target === 'erd.Goal')) || 
				((source && source === target) && !(source==='erd.Relationship')&&(cellViewS.model.get('id')!=cellViewT.model.get('id')))			

				;
				}
				
            });
						
            paper.on('blank:mousewheel', _.partial(this.onMousewheel, null), this);
            paper.on('cell:mousewheel', this.onMousewheel, this);
			
			// Identify link-type: Refinement, Contribution, Qualification or NeededBy
			// And store the linktype into the link
			function setLinkType(link){
				if (!link.getTargetElement() || !link.getSourceElement()){
					link.attr(".link-type", "Error");
				}
				var sourceCell = link.getSourceElement().attributes.type;
				var targetCell = link.getTargetElement().attributes.type;
				var sourceCellInActor = link.getSourceElement().get('parent');
				var targetCellInActor = link.getTargetElement().get('parent');

				switch(true){

					case ((sourceCell == "erd.Goal") && (targetCell == "erd.Goal")):
						link.attr(".link-type", "Valid");
						break;
					case ((sourceCell == "erd.Goal") && (targetCell == "basic.Quality")):
						link.attr(".link-type", "Valid");
						break;
					case ((sourceCell == "basic.Quality") && (targetCell == "erd.Goal")):
						link.attr(".link-type", "Valid");
						break;
					case ((sourceCell == "basic.Quality") && (targetCell == "basic.Quality")):
						link.attr(".link-type", "Valid");
						break;

					default:
						console.log('Default');
				}
			}

			paper.on('cell:pointerup', function(cellView, evt) {
				// Link
				if (cellView.model instanceof joint.dia.Link){
					var link = cellView.model;
					var sourceCell = link.getSourceElement();
					if(sourceCell===null){return;}
					setLinkType(link);
					var linktype = link.attr(".link-type");
					drawDefaultLink(link, linktype);
					// Check if link is valid or not
					if (link.getTargetElement()){
						var targetCell = link.getTargetElement().attributes.type;
					}
					return
				}
			});

			// Need to draw a link upon user creating link between 2 nodes
			// Given a link and linktype, draw the deafult link
			function drawDefaultLink(link, linktype){
				switch(linktype){
					case "Valid":
						link.label(0 ,{position: 0.5, attrs: {text: {text: azione}}});					
						break;
				}
			}
			
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
                search: {
                    '*': ['type', 'attrs/text/text', 'attrs/.label/text'],
                    'org.Member': ['attrs/.rank/text', 'attrs/.name/text']
                },
                // Use default Grid Layout
                layout: true,
                // Remove tooltip definition from clone
                dragStartClone: function(cell) {
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
									'data-tooltip': 'Click and drag to connect the object with an OR relationship',
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
									'data-tooltip': 'Click and drag to connect the object with an OR relationship',
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
                'to-front:pointerclick': _.bind(this.selection.collection.invoke, this.selection.collection, 'toFront'),
                'to-back:pointerclick': _.bind(this.selection.collection.invoke, this.selection.collection, 'toBack'),
                'layout:pointerclick': _.bind(this.layoutDirectedGraph, this),
                'snapline:change': _.bind(this.changeSnapLines, this),
                'clear:pointerclick': _.bind(this.graph.clear, this.graph),
                'print:pointerclick': _.bind(this.paper.print, this.paper),
                'grid-size:change': _.bind(this.paper.setGridSize, this.paper)
            });

            this.$('.toolbar-container').append(toolbar.el);
			this.$('.toolbar-container').append('<input class="menu-item" type="file" id="fileLoader" name="files" style="display:none" />');

            toolbar.render();
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
			var textFileAsBlob = new Blob([JSON.stringify(this.graph.toJSON())], {type:'text/plain'});
			saveAs(textFileAsBlob, "fileJSON");
		},
		
		saveToDB: function() {
			$('#graphName').val($('#goalname').val());
			$('#supportContent').val(JSON.stringify(this.graph.toJSON()));
			$('#formtosub').submit();
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
        }
    });

})(_, joint);