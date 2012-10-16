

class IRColor

  COLOR_CODE = "\x03" # \u0003
  BOLD       = "\x02" # \u0002
  UNDERLINE  = "\x1f" # \u001F
  INVERSE    = "\x16" # \u0016
  CLEAR      = "\x0f" # \u000F

  COLOR_TABLE = {
      0  => %w(white),
      1  => %w(black),
      2  => %w(blue navy),
      3  => %w(green),
      4  => %w(red),
      5  => %w(brown maroon),
      6  => %w(purple),
      7  => %w(orange olive),
      8  => %w(yellow),
      9  => %w(light_green lime),
      10 => %w(teal a_green blue_cyan),
      11 => %w(light_cyan cyan aqua),
      12 => %w(light_blue royal),
      13 => %w(pink light_purple fuchsia),
      14 => %w(grey),
      15 => %w(light_grey silver),
  }




  class << self
    def bold
      ircolor = IRColor.new()
      ircolor.bold
      ircolor
    end

    def underline
      ircolor = IRColor.new()
      ircolor.underline
      ircolor
    end

    def inverse
      ircolor = IRColor.new()
      ircolor.inverse
      ircolor
    end

    def italic
      ircolor = IRColor.new()
      ircolor.inverse
      ircolor
    end

    def clear
      ircolor = IRColor.new()
      ircolor.clear
      ircolor
    end
  end



  color_name_table = {}


  #summon forth the methods
  COLOR_TABLE.each do | code, colors |
    colors.each do |color|
      color_name_table[color] = code
      #instance methods
      define_method(color) do | *args |
        bg_color = args.first || nil
        if (!!bg_color and color_name_table.include?(bg_color))
          color_code = "#{COLOR_CODE}#{sprintf("%02d,%02d", code, color_name_table[bg_color])}"
        else
          color_code = "#{COLOR_CODE}#{sprintf("%02d", code)}"
        end
        add_code_l(color_code)
      end
      #class methods
      define_singleton_method(color) do | *args |
        ircolor = IRColor.new()
        ircolor.send(color)
        return ircolor
      end

    end
  end

  #non-class methods

  def bold
    add_code_l BOLD
  end

  def underline
    add_code_l UNDERLINE
  end

  def inverse
    add_code_l INVERSE
  end

  def italic
    add_code_l INVERSE
  end

  def clear
    add_code_l(CLEAR)
  end

  def stringfy
    #"#{@string}#{CLEAR}"
    "#{@string}"
  end

  alias_method :to_s, :stringfy
  alias_method :to_str, :stringfy

  private
  def add_code_l(code)
    @string = "#{@string}#{code}"
    self
  end


end