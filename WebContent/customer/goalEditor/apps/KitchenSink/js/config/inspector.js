var App = App || {};
App.config = App.config || {};

(function() {

    'use strict';

    
    App.config.inspector = {

        'app.Link': {
            inputs: {
               
                'labels': [
                    {attrs: {
                        text: {
                            text: {
    							type: 'select-box',
    							options: [
    								{ content: 'IMPACT'},
    								{ content: 'CONFLICT',selected: true}		
    							],		
    							label: 'Relation',
    							group: 'labels',					
    							index: 1
                            }
                        },
    					'.name': {
    						text: {
    							type: 'content-editable',
    							label: 'Description',
    							group: 'labels',
    							index: 2
    						}					
    					}
                    }}
                ],
            },
            groups: {

                labels: {
                    label: 'Labels',
                    index: 1
                }
            }
        },
        'basic.Quality': {
            inputs: {
                attrs: {
					text: {
						text: {
							type: 'content-editable',
							label: 'Name',
							group: 'text',
							index: 1
						}
					},				
					'.body': {
						text: {
							type: 'content-editable',
							label: 'Body',
							group: 'text',
							index: 2
						}					
					},
					'.description': {
						text: {
							type: 'content-editable',
							label: 'Description',
							group: 'text',
							index: 3
						}					
					}
                }
            },
            groups: {
                text: {
                    label: 'Properties',
                    index: 1
                }
            }
        },
        'erd.Relationship': {
            inputs: {
                attrs: {
                    text: {
                        text: {
							type: 'select-box',
							options: [
								{ content: 'AND'},
								{ content: 'OR',selected: true}		
							],		
							label: 'Relation',
							group: 'property',					
							index: 1
                        }
                    },
					'.name': {
						text: {
							type: 'content-editable',
							label: 'Description',
							group: 'property',
							index: 2
						}					
					}
                }
            },
            groups: {
                property: {
                    label: 'Property',
                    index: 1
                },					
                presentation: {
                    label: 'Presentation',
                    index: 2
                },
                text: {
                    label: 'Text',
                    index: 3
                }
				
            }
        },
        'erd.Goal': {
             inputs: {
                attrs: {
					'text': {
						text: {
							type: 'content-editable',
							label: 'Name',
							group: 'text',
							index: 1
						}
					},				
					'.body': {
						text: {
							type: 'content-editable',
							label: 'Body',
							group: 'text',
							index: 2
						}					
					},
					'.description': {
						text: {
							type: 'content-editable',
							label: 'Description',
							group: 'text',
							index: 3
						}					
					},
					'.priority': {
						text: {
							type: 'number',
							min: "1",
							label: 'Priority',
							group: 'text',
							index: 4
						}					
					},
					'.actors': {
						text: {
							type: 'content-editable',
							label: 'Actors',
							group: 'text',
							index: 5
						}					
					},
					'.idDB': {
						text: {
						}					
					}
                }
            },
            groups: {
                text: {
                    label: 'Properties',
                    index: 1
                }
            }
        }
            
        
    };

})();
