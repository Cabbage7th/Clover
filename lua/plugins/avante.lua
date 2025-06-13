local M = {
	-- Set the default provider to "qwen
	provider = "qwen", -- "doubao" or "llama"
	-- Define a table of vendors with their respective configurations
	providers = {
		qwen = {
			__inherited_from = "openai",
			api_key_name = "DASHSCOPE_API_KEY",
			--endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions",
			endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1",
			--model = "qwen2.5-72b-instruct",
			--model = "qwq-plus",
			model = "qwen-coder-plus",
		},
		doubao = {
			__inherited_from = "openai",
			api_key_name = "DOUBAO_API_KEY",
			endpoint = "https://ark.cn-beijing.volces.com/api/v3/chat/completions",
			model = "ep-20241003171329-8wvbs",
		},
	},
}

return M
