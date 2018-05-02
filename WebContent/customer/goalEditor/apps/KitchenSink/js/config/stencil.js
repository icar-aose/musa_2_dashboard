var App = App || {};
App.config = App.config || {};

(function() {

    'use strict';

    App.config.stencil = {};

    App.config.stencil.groups = {	
        erd: { index: 1, label: 'Goal' },
		basic: { index: 2, label: 'Soft Goal' }
		
    };

    App.config.stencil.shapes = {};

    App.config.stencil.shapes.basic = [	
        {
            type: 'basic.Quality',
            size: { width: 53, height: 42 },
            attrs: {
                '.': {
                    'data-tooltip': 'Soft Goal',
                    'data-tooltip-position': 'left',
                    'data-tooltip-position-selector': '.joint-stencil'
                },
                image: {
                    width: 53,
                    height: 42,
					'xlink:href': 'assets/cloud.svg',
                },
                text: {
                    text: 'Quality',
                    'font-size': 11,
                    'font-family': 'Roboto Condensed',
                    'font-weight': 'Normal',
                    fill: '#000000',
                    'stroke-width': 1
                }
            }
        }
    ];
	
    App.config.stencil.shapes.fsa = [

        {
            type: 'fsa.StartState',
            preserveAspectRatio: true,
            attrs: {
                '.': {
                    'data-tooltip': 'Start State',
                    'data-tooltip-position': 'left',
                    'data-tooltip-position-selector': '.joint-stencil'
                },
                circle: {
                    width: 50,
                    height: 30,
                    fill: '#61549C',
                    'stroke-width': 0
                },
                text: {
                    text: 'startState',
                    fill: '#c6c7e2',
                    'font-family': 'Roboto Condensed',
                    'font-weight': 'Normal',
                    'font-size': 11,
                    'stroke-width': 0
                }
            }
        },
        {
            type: 'fsa.EndState',
            preserveAspectRatio: true,
            attrs: {
                '.': {
                    'data-tooltip': 'End State',
                    'data-tooltip-position': 'left',
                    'data-tooltip-position-selector': '.joint-stencil'
                },
                '.inner': {
                    fill: '#6a6c8a',
                    stroke: 'transparent'
                },
                '.outer': {
                    fill: 'transparent',
                    stroke: '#61549C',
                    'stroke-width': 2,
                    'stroke-dasharray': '0'
                },
                text: {
                    text: 'endState',
                    fill: '#c6c7e2',
                    'font-family': 'Roboto Condensed',
                    'font-weight': 'Normal',
                    'font-size': 11,
                    'stroke-width': 0
                }
            }
        },
        {
            type: 'fsa.State',
            preserveAspectRatio: true,
            attrs: {
                '.': {
                    'data-tooltip': 'State',
                    'data-tooltip-position': 'left',
                    'data-tooltip-position-selector': '.joint-stencil'
                },
                circle: {
                    fill: '#6a6c8a',
                    stroke: '#61549C',
                    'stroke-width': 2,
                    'stroke-dasharray': '0'
                },
                text: {
                    text: 'state',
                    fill: '#c6c7e2',
                    'font-family': 'Roboto Condensed',
                    'font-weight': 'Normal',
                    'font-size': 11,
                    'stroke-width': 0
                }
            }
        }
    ];

    App.config.stencil.shapes.pn = [

        {
            type: 'pn.Place',
            preserveAspectRatio: true,
            tokens: 3,
            attrs: {
                '.': {
                    'data-tooltip': 'Place',
                    'data-tooltip-position': 'left',
                    'data-tooltip-position-selector': '.joint-stencil'
                },
                '.root': {
                    fill: 'transparent',
                    stroke: '#61549C',
                    'stroke-width': 2,
                    'stroke-dasharray': '0'
                },
                '.tokens circle': {
                    fill: '#6a6c8a',
                    stroke: '#000',
                    'stroke-width': 0
                },
                '.label': {
                    text: '',
                    'font-family': 'Roboto Condensed',
                    'font-weight': 'Normal'
                }
            }
        },
        {
            type: 'pn.Transition',
            preserveAspectRatio: true,
            attrs: {
                '.': {
                    'data-tooltip': 'Transition',
                    'data-tooltip-position': 'left',
                    'data-tooltip-position-selector': '.joint-stencil'
                },
                rect: {
                    rx: 3,
                    ry: 3,
                    width: 12,
                    height: 50,
                    fill: '#61549C',
                    stroke: '#7c68fc',
                    'stroke-width': 0,
                    'stroke-dasharray': '0'
                },
                '.label': {
                    text: 'transition',
                    'font-family': 'Roboto Condensed',
                    'font-weight': 'Normal',
                    'stroke-width': 0,
                    'fill': '#222138'
                }
            }
        }
    ];

    App.config.stencil.shapes.erd = [
        {
            type: 'erd.Goal',
            attrs: {
                '.': {
                    'data-tooltip': 'Goal',
                    'data-tooltip-position': 'left',
                    'data-tooltip-position-selector': '.joint-stencil'
                },
                '.outer': {
                    fill: '#FFFFFF',
                    stroke: '#000000',
                    'stroke-width': 2,
                    'stroke-dasharray': '0'
                },
                text: {
                    text: 'Goal',
                    'font-size': 11,
                    'font-family': 'Roboto Condensed',
                    'font-weight': 'Normal',
                    fill: '#000000',
                    'stroke-width': 0
                }
            }
        
        }

    ];

    App.config.stencil.shapes.uml = [

        {
            type: 'uml.Class',
            name: 'Class',
            attributes: ['+attr1'],
            methods: ['-setAttr1()'],
            size: {
                width: 150,
                height: 100
            },
            attrs: {
                '.': {
                    'data-tooltip': 'Class',
                    'data-tooltip-position': 'left',
                    'data-tooltip-position-selector': '.joint-stencil'
                },
                '.uml-class-name-rect': {
                    top: 2,
                    fill: '#61549C',
                    stroke: '#f6f6f6',
                    'stroke-width': 1,
                    rx: 8,
                    ry: 8
                },
                '.uml-class-attrs-rect': {
                    top: 2,
                    fill: '#61549C',
                    stroke: '#f6f6f6',
                    'stroke-width': 1,
                    rx: 8,
                    ry: 8
                },
                '.uml-class-methods-rect': {
                    top: 2,
                    fill: '#61549C',
                    stroke: '#f6f6f6',
                    'stroke-width': 1,
                    rx: 8,
                    ry: 8
                },
                '.uml-class-name-text': {
                    ref: '.uml-class-name-rect',
                    'ref-y': 0.5,
                    'y-alignment': 'middle',
                    fill: '#f6f6f6',
                    'font-family': 'Roboto Condensed',
                    'font-weight': 'Normal',
                    'font-size': 11
                },
                '.uml-class-attrs-text': {
                    ref: '.uml-class-attrs-rect',
                    'ref-y': 0.5,
                    'y-alignment': 'middle',
                    fill: '#f6f6f6',
                    'font-family': 'Roboto Condensed',
                    'font-weight': 'Normal',
                    'font-size': 11
                },
                '.uml-class-methods-text': {
                    ref: '.uml-class-methods-rect',
                    'ref-y': 0.5,
                    'y-alignment': 'middle',
                    fill: '#f6f6f6',
                    'font-family': 'Roboto Condensed',
                    'font-weight': 'Normal',
                    'font-size': 11
                }
            }
        },
        {
            type: 'uml.Interface',
            name: 'Interface',
            attributes: ['+attr1'],
            methods: ['-setAttr1()'],
            size: {
                width: 150,
                height: 100
            },
            attrs: {
                '.': {
                    'data-tooltip': 'Interface',
                    'data-tooltip-position': 'left',
                    'data-tooltip-position-selector': '.joint-stencil'
                },
                '.uml-class-name-rect': {
                    fill: '#fe854f',
                    stroke: '#f6f6f6',
                    'stroke-width': 1,
                    rx: 8,
                    ry: 8
                },
                '.uml-class-attrs-rect': {
                    fill: '#fe854f',
                    stroke: '#f6f6f6',
                    'stroke-width': 1,
                    rx: 8,
                    ry: 8
                },
                '.uml-class-methods-rect': {
                    fill: '#fe854f',
                    stroke: '#f6f6f6',
                    'stroke-width': 1,
                    rx: 8,
                    ry: 8
                },
                '.uml-class-name-text': {
                    ref: '.uml-class-name-rect',
                    'ref-y': 0.5,
                    'y-alignment': 'middle',
                    fill: '#f6f6f6',
                    'font-family': 'Roboto Condensed',
                    'font-weight': 'Normal',
                    'font-size': 11
                },
                '.uml-class-attrs-text': {
                    ref: '.uml-class-attrs-rect',
                    'ref-y': 0.5,
                    'y-alignment': 'middle',
                    fill: '#f6f6f6',
                    'font-family': 'Roboto Condensed',
                    'font-size': 11
                },
                '.uml-class-methods-text': {
                    ref: '.uml-class-methods-rect',
                    'ref-y': 0.5,
                    'y-alignment': 'middle',
                    fill: '#f6f6f6',
                    'font-family': 'Roboto Condensed',
                    'font-weight': 'Normal',
                    'font-size': 11
                }
            }
        },
        {
            type: 'uml.Abstract',
            name: 'Abstract',
            attributes: ['+attr1'],
            methods: ['-setAttr1()'],
            size: {
                width: 150,
                height: 100
            },
            attrs: {
                '.': {
                    'data-tooltip': 'Abstract',
                    'data-tooltip-position': 'left',
                    'data-tooltip-position-selector': '.joint-stencil'
                },
                '.uml-class-name-rect': {
                    fill: '#6a6c8a',
                    stroke: '#f6f6f6',
                    'stroke-width': 1,
                    rx: 8,
                    ry: 8
                },
                '.uml-class-attrs-rect': {
                    fill: '#6a6c8a',
                    stroke: '#f6f6f6',
                    'stroke-width': 1,
                    rx: 8,
                    ry: 8
                },
                '.uml-class-methods-rect': {
                    fill: '#6a6c8a',
                    stroke: '#f6f6f6',
                    'stroke-width': 1,
                    rx: 8,
                    ry: 8
                },
                '.uml-class-name-text': {
                    ref: '.uml-class-name-rect',
                    'ref-y': 0.5,
                    'y-alignment': 'middle',
                    fill: '#f6f6f6',
                    'font-family': 'Roboto Condensed',
                    'font-weight': 'Normal',
                    'font-size': 11
                },
                '.uml-class-attrs-text': {
                    ref: '.uml-class-attrs-rect',
                    'ref-y': 0.5,
                    'y-alignment': 'middle',
                    fill: '#f6f6f6',
                    'font-family': 'Roboto Condensed',
                    'font-weight': 'Normal',
                    'font-size': 11
                },
                '.uml-class-methods-text': {
                    ref: '.uml-class-methods-rect',
                    'ref-y': 0.5,
                    'y-alignment': 'middle',
                    fill: '#f6f6f6',
                    'font-family': 'Roboto Condensed',
                    'font-weight': 'Normal',
                    'font-size': 11
                }
            }
        },

        {
            type: 'uml.State',
            name: 'State',
            events: ['entry/', 'create()'],
            size: {
                width: 150,
                height: 100
            },
            attrs: {
                '.': {
                    'data-tooltip': 'State',
                    'data-tooltip-position': 'left',
                    'data-tooltip-position-selector': '.joint-stencil'
                },
                '.uml-state-body': {
                    fill: '#feb663',
                    stroke: '#f6f6f6',
                    'stroke-width': 1,
                    rx: 8,
                    ry: 8,
                    'stroke-dasharray': '0'
                },
                '.uml-state-separator': {
                    stroke: '#f6f6f6',
                    'stroke-width': 1,
                    'stroke-dasharray': '0'
                },
                '.uml-state-name': {
                    fill: '#f6f6f6',
                    'font-size': 11,
                    'font-family': 'Roboto Condensed',
                    'font-weight': 'Normal'
                },
                '.uml-state-events': {
                    fill: '#f6f6f6',
                    'font-size': 11,
                    'font-family': 'Roboto Condensed',
                    'font-weight': 'Normal'
                }
            }
        }
    ];

    App.config.stencil.shapes.org = [

        {
            type: 'org.Member',
            attrs: {
                '.': {
                    'data-tooltip': 'Member',
                    'data-tooltip-position': 'left',
                    'data-tooltip-position-selector': '.joint-stencil'
                },
                '.rank': {
                    text: 'Rank',
                    fill: '#f6f6f6',
                    'font-family': 'Roboto Condensed',
                    'font-size': 12,
                    'font-weight': 'Bold',
                    'text-decoration': 'none'
                },
                '.name': {
                    text: 'Person',
                    fill: '#f6f6f6',
                    'font-family': 'Roboto Condensed',
                    'font-weight': 'Normal',
                    'font-size': 10
                },
                '.card': {
                    fill: '#31d0c6',
                    stroke: 'transparent',
                    'stroke-width': 0,
                    'stroke-dasharray': '0'
                },
                image: {
                    width: 32,
                    height: 32,
                    x: 16,
                    y: 13,
                    ref: null,
                    'ref-x': null,
                    'ref-y': null,
                    'y-alignment': null,
                    'xlink:href': 'assets/member-male.png'
                }
            }
        }
    ];

})();
