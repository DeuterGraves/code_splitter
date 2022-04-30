  class StripCodes
  # pass in the extensions - more versatile

  def self.get_orphan_codes(input_file, output_filename)
    strings_data = File.read(input_file).split

    mp4s = build_array(strings_data, "mp4")
    srts = build_array(strings_data, "srt")

    mp4_codes = get_codes(mp4s)
    srt_codes = get_codes(srts)

    orphan_codes = mp4_codes - srt_codes

    codes = orphan_codes.uniq

    save_to_file(codes, output_filename)
  end

  def self.update_code_list(codes_file, new_files_list, output_filename)
    requested_codes = File.read(codes_file).split
    new_files = File.read(new_files_list).split

    new_codes = build_codes_array(new_files)

    updated_codes = requested_codes - new_codes

    save_to_file(updated_codes, output_filename)
  end

  def self.list_mismatched_file_names(input_file, output_filename)
    files_strings = File.read(input_file).split
    mp4s = build_array(files_strings, "mp4")
    srts = build_array(files_strings, "srt")
    mp4s_hash = {}
    srts_hash = {}

    mp4s.each do |mp4|
      code = mp4.split("_")[-2]
      mp4s_hash[code] = mp4
    end

    srts.each do |srt|
      code = srt.split("_")[-2]
      srts_hash[code] = srt
    end

    srts_hash.each_pair do |k, v|
      next if mp4s_hash[k] == v || mp4s_hash[k].nil?
      puts "#{k}:\nSRT filename is #{v}\nMP4 filename is #{mp4s_hash[k]}"
      # rather than puts, save output.
    end;nil
  end

  def self.check_for_duplicates(input_file, extension)
    files_strings = File.read(input_file).split
    file_array = build_array(files_strings, extension)
    
    codes = get_codes(file_array)

    uniq?(codes)
  end

  def self.get_duplicate_codes(input_file, extension, output_filename)
    files_strings = File.read(input_file).split
    file_array = build_array(files_strings, extension)
    codes = get_codes(file_array)

    duplicates = codes.group_by{ |e| e }.select { |k, v| v.size > 1 }.map(&:first)

    save_to_file(duplicates, output_filename)
  end

  # input_file, output_filename, codes_file, new_files_list, extension = ARGV


  private

  def self.build_array(strings_data, extension)
    array = []

    strings_data.each do |string|
      if string.split(".").last == extension
        array << string.chomp(".#{extension}")
      end
    end 
    array 
  end

  def self.get_codes(filenames)
    codes = []

    filenames.each do |filename| 
      code = filename.split("_")[-2]
      codes << code
    end
    codes
  end

  def self.save_to_file(codes, output_filename)
    # binding.pry
    output = File.open("#{output_filename}.txt", 'w')
    output << codes
    output.close
  end

  def self.build_codes_array(strings_data)
    new_codes = []

    strings_data.each do |file|
      new_code = file.split("_")[-2]
      new_codes << new_code
    end

    new_codes
  end

  def self.uniq?(array)
    array.length == array.uniq.length
  end

  # rename file:
  # File.rename("../rename_me_1.txb", "../rename_me_01.txb")

  end

