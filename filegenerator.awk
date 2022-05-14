#This script takes Values from a csv, replaces Strings in a template svg and saves the results in an svg directory.
BEGIN{RS="^$"}

# takes content from svg file and saves it in template.
FILENAME==ARGV[1] {
        template = $0
        RS="\n";
        FS=","
}

# saves header Fields (first record) from csv.
FNR==1 && FILENAME==ARGV[2]{
        for (i = 1 ; i <= NF ; i++){
                headers[i] = $i
        }
}

# every following record after Header will be values. The values will replace Strings in the svg Template matching header fields in the SVG.
FNR>1 && FILENAME==ARGV[2]{
        result = template
        for (i in headers){
                gsub(headers[i],$i,result)
        }
        print result > "svg/" $1 ".svg"
}
