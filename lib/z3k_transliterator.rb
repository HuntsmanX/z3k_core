class Z3kTransliterator

  @@rules = {
    'а' => 'a',
    'б' => 'b',
    'в' => 'v',
    'г' => 'g',
    'д' => 'd',
    'е' => Proc.new { |pr, nx| %w(ь ъ).include?(pr) ? 'ye' : 'e' },
    'ё' => 'yo',
    'ж' => 'zh',
    'з' => 'z',
    'и' => 'i',
    'й' => Proc.new { |pr, nx| %w(а о э и у ы е ё ю я).include?(nx) ? 'j' : 'y' },
    'к' => 'k',
    'л' => 'l',
    'м' => 'm',
    'н' => 'n',
    'о' => 'o',
    'п' => 'p',
    'р' => 'r',
    'с' => 's',
    'т' => 't',
    'у' => 'u',
    'ф' => 'f',
    'х' => 'kh',
    'ц' => 'ts',
    'ч' => 'ch',
    'ш' => 'sh',
    'щ' => 'sch',
    'ъ' => Proc.new { |pr, nx| ['е'].include?(nx) ? 'y' : '' },
    'ы' => 'y',
    'ь' => Proc.new { |pr, nx| ['е'].include?(nx) ? 'y' : '' },
    'э' => 'e',
    'ю' => 'yu',
    'я' => 'ya',
    'ый' => 'y',
    'кс' => 'x'
  }

  def self.transliterate(string)
    characters = split string
    characters.each_with_index.map do |char, index|
      if @@rules[char].respond_to? :call
        @@rules[char].call (index == 0 ? nil : characters[index - 1]), characters[index + 1]
      else
        @@rules[char]
      end
    end.join.capitalize
  end

  def self.transliterate_name(string)
    name = string.strip.capitalize
    Transliteration.find_by_russian(name).try(:english)
  end

  private

  def self.split(string)
    characters = string.mb_chars.strip.downcase.to_s.chars
    characters.each_with_index do |char, index|
      next_char = characters[index + 1]
      if char == 'ы' && next_char == 'й' || char == 'к' && next_char == 'с'
        characters[index] = char + next_char
        characters.delete_at(index + 1)
      end
    end
  end

end