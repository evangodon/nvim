-- Global functions

-- Global notification function
Notify = {}
function Notify.info(msg)
  vim.notify(msg, vim.log.levels.INFO)
end

function Notify.warn(msg)
  vim.notify(msg, vim.log.levels.WARN)
end

function Notify.error(msg)
  vim.notify(msg, vim.log.levels.ERROR)
end

-- Pretty print lua code with Notify
function P(value)
  Notify.info(vim.inspect(value))
end

function Get_loaded_buffers()
  local loaded_buffers = vim.tbl_filter(function(buf)
    return vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_option(buf, "buflisted")
  end, vim.api.nvim_list_bufs())
  return loaded_buffers
end

-- Format string for ex command
function CMD(command)
  return string.format(":%s<cr>", command)
end
