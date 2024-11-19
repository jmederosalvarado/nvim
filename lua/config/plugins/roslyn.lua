return {
	"seblj/roslyn.nvim",
	ft = "cs",
	opts = {
		config = {
			settings = {
				-- These settings control how the completions behave.
				["csharp|completion"] = {
					-- Enables support for showing unimported types and unimported extension methods in completion lists.
					-- Expected values: true, false
					dotnet_show_completion_items_from_unimported_namespaces = true,

					-- Perform automatic object name completion for the members that you have recently selected.
					-- Expected values: true, false
					dotnet_show_name_completion_suggestions = true,
				},
				-- These settings control what inlay hints should be displayed.
				["csharp|inlay_hints"] = {
					-- Show hints for implicit object creation.
					-- Expected values: true, false
					csharp_enable_inlay_hints_for_implicit_object_creation = true,

					-- Show hints for variables with inferred types.
					-- Expected values: true, false
					csharp_enable_inlay_hints_for_implicit_variable_types = true,

					-- Show hints for lambda parameter types.
					-- Expected values: true, false
					csharp_enable_inlay_hints_for_lambda_parameter_types = true,

					-- Display inline type hints.
					-- Expected values: true, false
					csharp_enable_inlay_hints_for_types = true,

					-- Show hints for indexers.
					-- Expected values: true, false
					dotnet_enable_inlay_hints_for_indexer_parameters = true,

					-- Show hints for literals.
					-- Expected values: true, false
					dotnet_enable_inlay_hints_for_literal_parameters = true,

					-- Show hints for 'new' expressions.
					-- Expected values: true, false
					dotnet_enable_inlay_hints_for_object_creation_parameters = true,

					-- Show hints for everything else.
					-- Expected values: true, false
					dotnet_enable_inlay_hints_for_other_parameters = true,

					-- Display inline parameter name hints.
					-- Expected values: true, false
					dotnet_enable_inlay_hints_for_parameters = true,

					-- Suppress hints when parameter names differ only by suffix.
					-- Expected values: true, false
					dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,

					-- Suppress hints when argument matches parameter name.
					-- Expected values: true, false
					dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,

					-- Suppress hints when parameter name matches the method's intent.
					-- Expected values: true, false
					dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
				},
				["csharp|code_lens"] = {
					dotnet_enable_references_code_lens = true,
				},
				-- This setting controls how the language server should search for symbols.
				["csharp|symbol_search"] = {
					-- Search symbols in reference assemblies.
					-- Expected values: true, false
					dotnet_search_reference_assemblies = true,
				},
			},
		},
		choose_sln = nil,
	},
}
