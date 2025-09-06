local M = {
	strategies = {
		chat = {
			adapter = "kimi",
		},
		inline = {
			adapter = "kimi",
		},
	},
	opts = {
		language = "Chinese",
	},
	adapters = {
		http = {
			kimi = function()
				return require("codecompanion.adapters").extend("openai_compatible", {
					name = "kimi",
					url = "https://api.moonshot.cn/v1/chat/completions",
					env = {
						api_key = function()
							return os.getenv("KIMI_API_KEY")
						end,
					},
					schema = {
						model = {
							default = function()
								return os.getenv("KIMI_MODE_NAME")
							end,
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
							default = "qwen3-coder-flash",  -- define llm model to be used
						},
					},
				})
			end,
		}
	},
}

return M

