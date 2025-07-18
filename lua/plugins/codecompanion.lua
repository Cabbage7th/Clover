local M = {
	strategies = {
		chat = {
			adapter = "copilot",
		},
		inline = {
			adapter = "copilot",
		},
	},
	opts = {
		language = "Chinese",
	},
	adapters = {
		kimi_k2 = function()
			return require("codecompanion.adapters").extend("openai_compatible", {
				name = "kimi_k2",
				url = "https://api.moonshot.cn/v1/chat/completions",
				env = {
					api_key = function()
						return os.getenv("KIMI_API_KEY")
					end,
				},
				schema = {
					model = {
						default = "kimi-k2-0711-preview",
						choices = {
							["kimi-k2-0711-preview"] = { opts = { stream = true } },
						},
					},
				},
			})
		end,
		deepseek = function()
			return require("codecompanion.adapters").extend("deepseek", {
				url = "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions",
				env = {
					api_key = function()
						return os.getenv("DASHSCOPE_API_KEY")
					end,
				},
				schema = {
					model = {
						default = "deepseek-r1",
						choices = {
							["deepseek-r1"] = { opts = { can_reason = true } },
						},
					},
				},
			})
		end,
		aliyun_deepseek = function()
			return require("codecompanion.adapters").extend("openai_compatible", {
				name = "aliyun_deepseek",
				url = "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions",
				env = {
					api_key = function()
						return os.getenv("DASHSCOPE_API_KEY")
					end,
				},
				schema = {
					model = {
						default = "deepseek-r1",
						choices = {
							["deepseek-r1"] = { opts = { can_reason = true } },
						},
					},
				},
			})
		end,
		qwen = function()
			return require("codecompanion.adapters").extend("openai_compatible", {
				env = {
					-- url only is enough
					url = "https://dashscope.aliyuncs.com", -- optional: default value is ollama url http://127.0.0.1:11434
					api_key = function()
						return os.getenv("DASHSCOPE_API_KEY")
					end,
					-- url+chat_url is enough, too
					chat_url = "/compatible-mode/v1/chat/completions", -- optional: default value, override if different
					models_endpoint = "compatible-mode/v1/chat/completions", -- optional: attaches to the end of the URL to form the endpoint to retrieve models
				},
				schema = {
					model = {
						default = "qwen-plus",  -- define llm model to be used
					},
				},
			})
		end,
		-- doubao maybe out of time
		doubao = function()
			return require("codecompanion.adapters").extend("openai_compatible", {
				env = {
					url = "https://ark.cn-beijing.volces.com/api/v3/chat/completions",
					api_key = function()
						return os.getenv("DOUBAO_API_KEY")
					end,
				},
				schema = {
					model = {
						default = "ep-20241003171329-8wvbs",  -- define llm model to be used
					},
				},
			})
		end,
	},
}

return M

