generated-reduction actions
reduceActionForNegativeOperation1: nodes
	| result |
	result := UQLNegativeOperationNode new.
	result operator: (nodes at: 1).
	result exp: (nodes at: 2).
	^ result