$content = Get-Content ./Day1Input.txt
$result = 0
foreach ($line in $content){
      $line = $line `
         -replace "one","o1e" `
         -replace "two","t2o"`
         -replace "three","th3ee"`
         -replace "four","fo4ur"`
         -replace "five","fi5ve"`
         -replace "six","s6x"`
         -replace "seven","se7en"`
         -replace "eight","ei8ht"`
         -replace "nine","ni9ne"
      $digit = [regex]::Matches($line,"\d")
      [string]$stringNumber = [string]$digit[0].Value + [string]$digit[$digit.Count-1].Value
      $result+= [int]$stringNumber
}
return $result
