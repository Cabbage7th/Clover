local M = {
	-- Set the default provider to "qwen
	provider = "qwen", -- "doubao" or "llama"
	-- Define a table of vendors with their respective configurations
	vendors = {
		qwen = {
			endpoint = "https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions",
			model = "qwen2.5-72b-instruct",
			--model = "qwen-max-latest",
			--model = "qwen-coder-turbo-latest",
			--model = "qwen2.5-coder-7b-instruct",
			api_key_name = "DASHSCOPE_API_KEY",
			parse_curl_args = function(opts, code_opts)
				return {
					url = opts.endpoint,
					headers = {
						["Accept"] = "application/json",
						["Content-Type"] = "application/json",
						["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
					},
					body = {
						model = opts.model,
						messages = { -- you can make your own message, but this is very advanced
							{ role = "system", content = code_opts.system_prompt },
							{ role = "user", content = require("avante.providers.openai").get_user_message(code_opts) },
						},
						temperature = 0,
						max_tokens = 8192,
						stream = true, -- this will be set by default.
					},
				}
			end,
			parse_response_data = function(data_stream, event_state, opts)
				require("avante.providers").openai.parse_response(data_stream, event_state, opts)
			end,
		},
		doubao = {
			endpoint = "https://ark.cn-beijing.volces.com/api/v3/chat/completions",
			model = "ep-20241003171329-8wvbs",
			api_key_name = "DOUBAO_API_KEY",
			parse_curl_args = function(opts, code_opts)
				return {
					url = opts.endpoint,
					headers = {
						["Accept"] = "application/json",
						["Content-Type"] = "application/json",
						["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
					},
					body = {
						model = opts.model,
						messages = { -- you can make your own message, but this is very advanced
							{ role = "system", content = code_opts.system_prompt },
							{ role = "user", content = require("avante.providers.openai").get_user_message(code_opts) },
						},
						temperature = 0,
						max_tokens = 4096,
						stream = true, -- this will be set by default.
					},
				}
			end,
			parse_response_data = function(data_stream, event_state, opts)
				require("avante.providers").openai.parse_response(data_stream, event_state, opts)
			end,
		},
		llama = { -- from bytedance
			endpoint = "https://ark.cn-beijing.volces.com/api/v3/chat/completions",
			model = "ep-20241003164120-vfdg7",

			api_key_name = "DOUBAO_API_KEY",
			parse_curl_args = function(opts, code_opts)
				return {
					url = opts.endpoint,
					headers = {
						["Accept"] = "application/json",
						["Content-Type"] = "application/json",
						["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
					},
					body = {
						model = opts.model,
						messages = { -- you can make your own message, but this is very advanced
							{ role = "system", content = code_opts.system_prompt },
							{ role = "user", content = require("avante.providers.openai").get_user_message(code_opts) },
						},
						temperature = 0,
						max_tokens = 4096,
						stream = true, -- this will be set by default.
					},
				}
			end,
			parse_response_data = function(data_stream, event_state, opts)
				require("avante.providers").openai.parse_response(data_stream, event_state, opts)
			end,
		},
	},
}

return M
