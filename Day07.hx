using StringTools;
// haxe --interp --main Day07.hx

class Day07 {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/07.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/07.txt")));    
    }


    static function handScore(hand: String):Int {

        var l = 0;
        for(i in 0...hand.length) {
            for(j in i+1...hand.length) {
                if (hand.charAt(i) == hand.charAt(j)) {
                    l++;
                }
            }
        }

        return l;
    }

    static function carVal(card:String) {
        return switch card {
            case "T": 10;
            case "J": 11;
            case "Q": 12;
            case "K": 13;
            case "A": 14;
           case _: Std.parseInt(card);

        }
        
    }
    static function scoring(a1: Array<String>, a2: Array<String>):Int {
        var s1 = handScore(a1[0]);
        var s2 = handScore(a2[0]); 
        if (s1 == s2) {
            for (i in 0...a1[0].length) {
                var v1 = carVal(a1[0].charAt(i));
                var v2 = carVal(a2[0].charAt(i));
                if (v1 < v2) return -1;
                else if(v1 > v2) return 1;

            }
        }
        return  s1 - s2;
        
    }

    static function part1(input:Array<Array<String>>):Int {
        input.sort(scoring);
        trace(input);
        var total = 0;
        var i = 1;
        for (inp in input) {
            var v = Std.parseInt(inp[1]);
            total += v*i;
            i ++;

        }
        return total;
    }



    static function handScore2(hand: String):Int {
        var maxl = handScore(hand);

        var cards = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "Q", "K"];
        for (card in cards) {
            var newHand = hand.replace("J", card);
            if (newHand == hand) continue;
            var l = 0;

            for(i in 0...newHand.length) {
                for(j in i+1...newHand.length) {
                    if (newHand.charAt(i) == newHand.charAt(j)) {
                        l++;
                    }
                }
            }
            if (maxl < l) maxl = l;
        }
        return maxl;
    }

    static function carVal2(card:String) {
        return switch card {
            case "J": 1;
            case "T": 10;
            case "Q": 11;
            case "K": 12;
            case "A": 13;
           case _: Std.parseInt(card);
        }
        
    }
    static function scoring2(a1: Array<String>, a2: Array<String>):Int {
        var s1 = handScore2(a1[0]);
        var s2 = handScore2(a2[0]); 
        if (s1 == s2) {
            for (i in 0...a1[0].length) {
                var v1 = carVal2(a1[0].charAt(i));
                var v2 = carVal2(a2[0].charAt(i));
                if (v1 < v2) return -1;
                else if(v1 > v2) return 1;
            }
        }
        return  s1 - s2;
        
    }
    
    static function part2(input:Array<Array<String>>):Int {
        input.sort(scoring2);
        trace(input);

        var total = 0;
        var i = 1;
        for (inp in input) {
            var v = Std.parseInt(inp[1]);
            total += v*i;
            i++;
        }
        
        return total;
    }

    static function loadFile(file:String):Array<Array<String>> {
        var input:Array<Array<String>> = [];
        var iterator = sys.io.File.read(file, false);
        
        while (!iterator.eof()){
            var line = iterator.readLine();
            var inp = line.split(" ");
            input.push(inp);
        }
        iterator.close();
        return input;
    }
}