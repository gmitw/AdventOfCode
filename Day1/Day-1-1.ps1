$numbers = Get-Content .\input.txt

foreach($number in $numbers) {
    foreach($SecondNumber in $numbers) {
        $sum = [int]$number + [int]$SecondNumber
        if($sum -eq 2020) {
            $solution = [int]$number * [int]$SecondNumber
            write-host $solution
            exit
        }
    }
}