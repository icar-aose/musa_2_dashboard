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
                text: {
                    text: 'Quality'
                },
				'.body': {
					text: ''			
				},
				'.description': {
					text: ''				
				},
                '.': {
                    'data-tooltip': 'Soft Goal',
                    'data-tooltip-position': 'left',
                    'data-tooltip-position-selector': '.joint-stencil'
                },
				'.idDB': {
					text: ''			
				}
            }
        }
    ];
	
    App.config.stencil.shapes.erd = [
        {
            type: 'erd.Goal',
            attrs: {
                text: {
                    text: 'Goal'
                },
				'.body': {
					text: ''				
				},
				'.description': {
					text: ''			
				},
				'.priority': {
					text: ''			
				},
				'.actors': {
					text: ''			
				}
				,
				'.idDB': {
					text: ''			
				},
	            '.': {
	                'data-tooltip': 'Goal',
	                'data-tooltip-position': 'left',
	                'data-tooltip-position-selector': '.joint-stencil'
	            }
            }     
        }

    ];


})();
