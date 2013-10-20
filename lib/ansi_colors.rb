module AnsiColors
  class << self

    COLORS = {
      1  => 'bright',
      2  => 'dark',
      4  => 'underline',
      5  => 'blink',
      7  => 'negative',
      30 => 'black',
      31 => 'red',
      32 => 'green',
      33 => 'yellow',
      34 => 'blue',
      35 => 'magenta',
      36 => 'cyan',
      37 => 'white',
      40 => 'back-black',
      41 => 'back-red',
      42 => 'back_green',
      43 => 'back_yellow',
      44 => 'back_blue',
      45 => 'back_magenta',
      46 => 'back_cyan',
      47 => 'back_white'
    }

    def to_html(text)
      COLORS.each do |key, value|
        text.gsub!(/\[#{key}m/,"<span style=\"color:#{value}\">")
      end
      text.gsub!(/\[0m/,'</span>')
      text
    end

  end
end
