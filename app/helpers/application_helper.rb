# encoding: UTF-8
module ApplicationHelper
  THAI_PERIODS =
    {/about/    => "ประมาณ",
     /years?/   => "ปี",
     /months?/  => "เดือน",
     /weeks?/   => "สัปดาห์",
     /days?/    => "วัน",
     /hours?/   => "ชั่วโมง",
     /minutes?/ => "นาที",
     /seconds?/ => "วินาที",
     /less than/ => "ไม่เกิน",
     /\s+a\s+/ => ""
    }.freeze

  def thai_time str
    if str == "just now"
      "เมื่อกี้นี้"
    else
      THAI_PERIODS.inject(str) do |s, pair|
        s.gsub pair.first, pair.last
      end + "ที่แล้ว"
    end
  end
end
