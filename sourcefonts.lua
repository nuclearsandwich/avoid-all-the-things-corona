local SourceFonts = {}

SourceFonts.printFontNames = function()
	for i, fontname in ipairs(native.getFontNames()) do
		print(fontname)
	end
end

SourceFonts.findFontByName = function(name)
	name = string.lower(name)
	for i, fontname in ipairs(native.getFontNames()) do
		j, k = string.find(string.lower(fontname), name)

		if (j ~= nil) then
			print("fontname = " .. tostring(fontname))
		end
	end
end

SourceFonts.SourceCodePro_Black = "SourceCodePro-Black"
SourceFonts.SourceCodePro_Light = "SourceCodePro-Light"
SourceFonts.SourceCodePro_Regular = "SourceCodePro-Regular"
SourceFonts.SourceCodePro = "SourceCodePro-Regular"

return SourceFonts
