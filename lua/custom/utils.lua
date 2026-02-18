--
-- Utilities we want to use in multiple files
--
local utils = {}

-- Split a string into a table on newlines
function utils.split(phrase, delimiter)

	local result = {}
	local i = 1
    for str in string.gmatch(phrase .. delimiter, "([^" .. delimiter .. "]*)" .. delimiter) do
		result[i] = str
		i = i + 1
	end

	return result
end

-- Remove one string from the front of another
function utils.removeStringFromStart(haystack, needle)

    -- Check the start of the string matches what we are looking for
    if string.sub(haystack, 0, string.len(needle)) == needle then

        -- Return the remainder of the string
        return string.sub(haystack, string.len(needle) + 1, -1)
    end

    -- If no match, return the original string
    return haystack
end

return utils
