$data=get-content ./Day4Input.txt

function Part1($Data) {
    $total = 0

    foreach($line in $Data) {
        $match = 0
        $line = $line -replace '\s+', ' '
        $numbers = $line.split(':')[1]
        $win = $numbers.split('|')[0].trim().split(' ')
        $you = $numbers.split('|')[1].trim().split(' ')
        foreach($num in $win){
            if($you -contains $num) {
                if($match) {
                    $match = $match *2
                } else {
                    $match = 1
                }
            }
        }
        $total = $total + $match
    }

    return $total
}

function Part2($Data) {
    $cards = @(1) * ($Data.count + 1)
    $cards[0] = 0

    foreach($line in $Data) {
        $match = 0
        $line = $line -replace '\s+', ' '
        [int]$CardNo = $line.split(':')[0] -replace "[^0-9]"
        $numbers = $line.split(':')[1]
        $win = $numbers.split('|')[0].trim().split(' ')
        $you = $numbers.split('|')[1].trim().split(' ')
        foreach($num in $win){
            if($you -contains $num) {
                $match = $match + 1
            }
        }
        for($NoCardsCheck = 0; $NoCardsCheck -lt $cards[$CardNo];$NoCardsCheck++) {
            for($i = ($CardNo + 1); $i -le ($CardNo + $match); $i++) {
                $Cards[$i] = $Cards[$i] + 1
            }
        }
    }
    
    $Cards 
    | Measure-Object -Sum 
    | Select-Object -ExpandProperty Sum
}

Write-Output "Part 1: $(Part1 -Data $data)"
Write-Output "Part 2: $(Part2 -Data $data)"
