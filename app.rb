require "json"
require_relative 'mullet'

response = ""
total_price = 0;
path = "./mullets.json"
mullets = []
data = []
if File.exist?(path)
  data = JSON.parse(File.read(path))
end
data.each do |d|
  mullets << mullet = Mullet.new(d)
  total_price += mullet.price
end 



loop{
  system "clear"
  puts response if !response.empty?
  puts "1. 新增烏魚子"
  puts "2. 刪除烏魚子"
  puts "3. 總計"
  puts "4. 儲存"
  puts "5. 清空"
  puts "e. 離開"
  print "輸入選項:"
  user_action = gets.chomp!
  case user_action.upcase
  when "1"
      print "\t請輸入烏魚子幾兩 : "
      weight = gets.chomp!.to_f
    if weight==0
      response = "輸入錯誤，請重新輸入。"
      next
    end
    mullet = Mullet.new(weight)
    print "\t新增烏魚子:\n\t\t#{mullet.weight}兩/脾\t價格:#{mullet.price}$\t確定?(y/n)"
    confirm = gets.chomp!
    if confirm.upcase == "Y"
      mullets << mullet
      total_price += mullet.price
      response = "新增烏魚子:\t#{mullet.weight}兩/脾\t價格:#{mullet.price}$\t總共:#{total_price}$"
    else
      response = "取消"
    end

  when "2"
    mullet_total = mullets.length
    if mullet_total == 0
      response = "目前沒有任何烏魚子記錄。"
      next
    end
    print "\t請輸入想刪除第幾筆烏魚子 : "
    mullet_no = gets.chomp!.to_i
    if (1..mullet_total).include?(mullet_no)
      print "\t刪除烏魚子:\n\t\t#{mullets[mullet_no-1].weight}兩/脾\t價格:#{mullets[mullet_no-1].price}$\t確定?(y/n)"
      confirm = gets.chomp!
      if confirm.upcase == "Y"
        mullet = mullets.delete_at(mullet_no-1)
        total_price -= mullet.price
        response = "刪除烏魚子:\t#{mullet.weight}兩/脾\t價格:#{mullet.price}$\t總共:#{total_price}$"
      else
        response = "取消"
      end
    else
      response = "沒有烏魚子#{mullet_no}。"
    end

  when "3"
    response = "總計:\t#{total_price}$\t#{mullets.length}脾\n"
    mullets.each.with_index do |m,idx|
      response += "\t烏魚子 #{idx+1}\t#{m.weight}兩/脾\t價格:#{m.price}$\n"
    end
    response +="\n"
  when "4"
    print "\t將資料儲存於檔案#{File.path(path)}\t確定?(y/n)"
    confirm = gets.chomp!
    if confirm.upcase == "Y"
      data = []
      mullets.each do |m|
        data << m.weight
      end
      File.open(path,"w") do |f|
        f.write(JSON.pretty_generate(data))
      end
      response = "已經存檔"
    else
      response = "取消"
    end
  when "5"
    print "\t刪除所有烏魚子\t確定?(y/n)"
    confirm = gets.chomp!
    if confirm.upcase == "Y"
      mullets = []
      total_price = 0
      response = "已經刪除所有烏魚子"
    else
      response = "取消"
    end
  when "E"
    puts response="再見"
    break
  else
    response="沒有此選項"
  end

}
