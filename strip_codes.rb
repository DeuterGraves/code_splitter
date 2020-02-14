def get_codes(strings_file)
	strings_data = File.read(strings_file).split
	strings_data
end