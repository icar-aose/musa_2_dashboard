var App = App || {};
App.config = App.config || {};

(function() {

    'use strict';

    App.config.toolbar = {
        groups: {
            'home': { index: 1 },        	
            'undo-redo': { index: 2 },
            'clear': { index: 3 },
            'export': { index: 4 },
            'order': { index: 5 },
            'layout': { index: 6 },
            'zoom': { index: 7 },
            'grid': { index: 8 },
            'snapline': { index: 9 },
            'fullscreen': { index: 10 },
            'print': { index: 11 }

        },
        tools: [
        	
            {
                type: 'button',
                name: 'home',
                group: 'home',
                attrs: {
                    button: {
                        'data-tooltip': 'Go to Functional Requirements Page',
                        'data-tooltip-position': 'top',
                        'data-tooltip-position-selector': '.toolbar-container',
                        'onclick': 'location.href=listFunc'
                        	
                    }
                }
            },       	
            {
                type: 'undo',
                name: 'undo',
                group: 'undo-redo',
                attrs: {
                    button: {
                        'data-tooltip': 'Undo',
                        'data-tooltip-position': 'top',
                        'data-tooltip-position-selector': '.toolbar-container'
                    }
                }
            },
            {
                type: 'redo',
                name: 'redo',
                group: 'undo-redo',
                attrs: {
                    button: {
                        'data-tooltip': 'Redo',
                        'data-tooltip-position': 'top',
                        'data-tooltip-position-selector': '.toolbar-container'
                    }
                }
            },
            {
                type: 'button',
                name: 'clear',
                group: 'clear',
                attrs: {
                    button: {
                        id: 'btn-clear',
                        'data-tooltip': 'Clear Paper',
                        'data-tooltip-position': 'top',
                        'data-tooltip-position-selector': '.toolbar-container'
                    }
                }
            },  /*          
            {
                type: 'button',
                name: 'imp_json',
                group: 'export',
                text: 'Import JSON',
                attrs: {
                    button: {
                        id: 'btn-json',
                        'data-tooltip': 'Import JSON',
                        'data-tooltip-position': 'top',
                        'data-tooltip-position-selector': '.toolbar-container'
                    }
                }
            },*/	
            {
                type: 'selectBox',
                name: 'selectExport',
                group: 'export',
                id: 'selectExportId',
                openPolicy: 'below',
                selected: -1,
                placeholder: 'IMPORT-EXPORT',
                options: [
                    {value:1, content: 'Export PNG' },
                    {value:2, content: 'Export SVG' },
                    {value:3, content: 'Export JSON' },
                    {value:4, content: 'Import JSON' }

                ]
            },
            {
                type: 'separator',
                group: 'export'
            },
            
            {
                type: 'selectBox',
                name: 'selectInsert',
                group: 'export',
                id: 'selectInsertId',
                openPolicy: 'below',
                selected: -1,
                placeholder: 'INSERT',
                options: [
                    {value:1, content: 'Insert Manual Goal from DB' },
                    {value:2, content: 'Insert Manual Quality from DB' }
                ]
            },
            {
                type: 'separator',
                group: 'export'
            },
            {
                type: 'selectBox',
                name: 'selectSave',
                group: 'export',
                id: 'selectSaveId',
                openPolicy: 'below',
                selected: -1,
                placeholder: 'SAVE',
                options: [
                    {value:1, content: 'Save Graph to DB as JSON' },
                    {value:2, content: 'Save each Element to DB' }
                ]
            },
            {
                type: 'separator',
                group: 'export'
            },
            /*
            {
                type: 'button',
                name: 'svg',
                group: 'export',
                text: 'Export SVG',
                attrs: {
                    button: {
                        id: 'btn-svg',
                        'data-tooltip': 'Open as SVG in a pop-up',
                        'data-tooltip-position': 'top',
                        'data-tooltip-position-selector': '.toolbar-container'
                    }
                }
            },
            {
                type: 'button',
                name: 'png',
                group: 'export',
                text: 'Export PNG',
                attrs: {
                    button: {
                        id: 'btn-png',
                        'data-tooltip': 'Open as PNG in a pop-up',
                        'data-tooltip-position': 'top',
                        'data-tooltip-position-selector': '.toolbar-container'
                    }
                }
            },	
            {
                type: 'button',
                name: 'exp_json',
                group: 'export',
                text: 'Exp JSON',
                attrs: {
                    button: {
                        id: 'btn-json',
                        'data-tooltip': 'Export as JSON',
                        'data-tooltip-position': 'top',
                        'data-tooltip-position-selector': '.toolbar-container'
                    }
                }
            },			
            {
                type: 'button',
                name: 'saveDB',
                group: 'export',
                text: 'Graph to DB',
                attrs: {
                    button: {
                        id: 'btn_saveDB',
                        'data-tooltip': 'Save the Graph as JSON to DB',
                        'data-tooltip-position': 'top',
                        'data-tooltip-position-selector': '.toolbar-container'
                    }
                }
            },			
            {
                type: 'button',
                name: 'saveElementsDB',
                group: 'export',
                text: 'Elements to DB',
                attrs: {
                    button: {
                        id: 'btn_saveElementsDB',
                        'data-tooltip': 'Save each GOAL to DB',
                        'data-tooltip-position': 'top',
                        'data-tooltip-position-selector': '.toolbar-container'
                    }
                }
            },            

            {
                type: 'button',
                name: 'insertGoal',
                group: 'export',
                text: 'Ins Goal',
                attrs: {
                    button: {
                        id: 'insertGoal',
                        'data-tooltip': 'Insert Goal from DB',
                        'data-tooltip-position': 'top',
                        'data-tooltip-position-selector': '.toolbar-container'
                    }
                }
            },            

            {
                type: 'button',
                name: 'insertQuality',
                group: 'export',
                text: 'Ins Quality',
                attrs: {
                    button: {
                        id: 'insertQuality',
                        'data-tooltip': 'Insert Quality from DB',
                        'data-tooltip-position': 'top',
                        'data-tooltip-position-selector': '.toolbar-container'
                    }
                }
            },    */        

            {
                type: 'button',
                name: 'print',
                group: 'print',
                attrs: {
                    button: {
                        id: 'btn-print',
                        'data-tooltip': 'Open a Print Dialog',
                        'data-tooltip-position': 'top',
                        'data-tooltip-position-selector': '.toolbar-container'
                    }
                }
            },
            
            {
                type: 'button',
                name: 'to-front',
                group: 'order',
                text: 'To Front',
                attrs: {
                    button: {
                        id: 'btn-to-front',
                        'data-tooltip': 'Bring Object to Front',
                        'data-tooltip-position': 'top',
                        'data-tooltip-position-selector': '.toolbar-container'
                    }
                }
            },
            {
                type: 'button',
                name: 'to-back',
                group: 'order',
                text: 'To Back',
                attrs: {
                    button: {
                        id: 'btn-to-back',
                        'data-tooltip': 'Send Object to Back',
                        'data-tooltip-position': 'top',
                        'data-tooltip-position-selector': '.toolbar-container'
                    }
                }
            },
            {
                type: 'button',
                group: 'layout',
                name: 'layout',
                attrs: {
                    button: {
                        id: 'btn-layout',
                        'data-tooltip': 'Auto-layout Graph',
                        'data-tooltip-position': 'top',
                        'data-tooltip-position-selector': '.toolbar-container'
                    }
                }
            },
            {
                type: 'zoom-to-fit',
                name: 'zoom-to-fit',
                group: 'zoom',
                attrs: {
                    button: {
                        'data-tooltip': 'Zoom To Fit',
                        'data-tooltip-position': 'top',
                        'data-tooltip-position-selector': '.toolbar-container'
                    }
                }
            },
            {
                type: 'zoom-out',
                name: 'zoom-out',
                group: 'zoom',
                attrs: {
                    button: {
                        'data-tooltip': 'Zoom Out',
                        'data-tooltip-position': 'top',
                        'data-tooltip-position-selector': '.toolbar-container'
                    }
                }
            },
            {
                type: 'label',
                name: 'zoom-slider-label',
                group: 'zoom',
                text: 'Zoom:'
            },
            {
                type: 'zoom-slider',
                name: 'zoom-slider',
                group: 'zoom'
            },
            {
                type: 'zoom-in',
                name: 'zoom-in',
                group: 'zoom',
                attrs: {
                    button: {
                        'data-tooltip': 'Zoom In',
                        'data-tooltip-position': 'top',
                        'data-tooltip-position-selector': '.toolbar-container'
                    }
                }
            },
            {
                type: 'separator',
                group: 'grid'
            }/*,
            {
                type: 'label',
                name: 'grid-size-label',
                group: 'grid',
                text: 'Grid size:',
                attrs: {
                    label: {
                        'data-tooltip': 'Change Grid Size',
                        'data-tooltip-position': 'top',
                        'data-tooltip-position-selector': '.toolbar-container'
                    }
                }
            },
            {
                type: 'range',
                name: 'grid-size',
                group: 'grid',
                text: 'Grid size:',
                min: 1,
                max: 50,
                step: 1,
                value: 10
            },
            {
                type: 'separator',
                group: 'snapline'
            },
            {
                type: 'checkbox',
                name: 'snapline',
                group: 'snapline',
                label: 'Snaplines:',
                value: true,
                attrs: {
                    input: {
                        id: 'snapline-switch'
                    },
                    label: {
                        'data-tooltip': 'Enable/Disable Snaplines',
                        'data-tooltip-position': 'top',
                        'data-tooltip-position-selector': '.toolbar-container'
                    }
                }
            }*/,
            {
                type: 'fullscreen',
                name: 'fullscreen',
                group: 'fullscreen',
                attrs: {
                    button: {
                        'data-tooltip': 'Toggle Fullscreen Mode',
                        'data-tooltip-position': 'top',
                        'data-tooltip-position-selector': '.toolbar-container'
                    }
                }
            }
        ]
    };
})();
