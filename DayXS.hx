using StringTools;
// haxe --interp --main Day05.hx

class DayXX {
    static function main() {
        trace("solution to part 1: " + part1(loadFile("inputs/XX.txt")));
        trace("solution to part 2: " + part2(loadFile("inputs/XX.txt")));    
    }

    static function part1(input:Array<String>):Int {
        trace(input);
        return 0;
    }
    static function part2(input:Array<String>):Int {
        return 0;
    }

    static function loadFile(file:String):Array<String> {
        var input:Array<String> = [];
        var iterator = sys.io.File.read(file, false);
        
        while (!iterator.eof()){
            var line = iterator.readLine();
            input.push(line);
        }
        iterator.close();
        return input;
    }
}