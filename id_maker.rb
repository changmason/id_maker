

module IdMaker
  AREA = { 
    "A" => "臺北市", "B" => "臺中市", "C" => "基隆市", "D" => "臺南市",
    "E" => "高雄市", "F" => "新北市", "G" => "宜蘭縣", "H" => "桃園縣",
    "I" => "嘉義市", "J" => "新竹縣", "K" => "苗栗縣", "M" => "南投縣",
    "N" => "彰化縣", "O" => "新竹市", "P" => "雲林縣", "Q" => "嘉義縣",
    "T" => "屏東縣", "U" => "花蓮縣", "V" => "臺東縣", "W" => "金門縣",
    "X" => "澎湖縣", "Z" => "連江縣"}
  
  CODE = { 
    "A" => 10, "B" => 11, "C" => 12, "D" => 13, "E" => 14, "F" => 15,
    "G" => 16, "H" => 17, "I" => 34, "J" => 18, "K" => 19, "L" => 20,
    "M" => 21, "N" => 22, "O" => 35, "P" => 23, "Q" => 24, "R" => 25,
    "S" => 26, "T" => 27, "U" => 28, "V" => 29, "W" => 32, "X" => 30,
    "Y" => 31, "Z" => 32 }
  
  def self.generate(location = "A", sex = 1)
    while(true)
      array = [location, sex]
      8.times { array << rand(10) }
      test_id = array.join
      return test_id if self.verify(test_id)
    end
  end
  
  def self.verify(id)
    x1 = CODE[id[0..0]] / 10
    x2 = CODE[id[0..0]] % 10
    y = x1 + 9*x2
    (1..8).each { |i| y += (9 - i) * (id[i] - 48) }
    return (y % 10 + id[9] - 48) == 10
  end
end