jQuery.fn.flip = function(args){
        var borderConst = "border",
        widthConst = "Width",
        heightConst = "Height",
        topConst = "Top",
        rightConst = "Right",
        leftConst = "Left",
        bottomConst = "Bottom"
    ;
        var $helperNode = $("<div></div>");
        var $node = this, 
            s = $node[0].style,
            dims = null,
            hs = null, 
            pn = null,
            lightColor = args.lightColor || "#dddddd", 
            darkColor = args.darkColor || "#555555",
            bgColor = s["backgroundColor"], 
            endColor = args.endColor || bgColor,
            staticProps = {}, 
            anims = [],
            duration = args.duration ? args.duration / 2 : 250,
            dir = args.dir || "left", 
            pConst = 0.6, 
            transparentColor = "transparent"
            onEnd = args.onEnd || function(){},
            // IE6 workaround: IE6 doesn't support transparent borders
            convertColor = function(color){
                var re = new RegExp("#000000|#000|black|rgb(0,0,0)", "i");
                return re.test(color.replace(/ /, "")) ? "#000001" : color;
            };
        if($.browser.msie && parseInt($.browser.version) < 7){
            endColor = convertColor(endColor);
            lightColor = convertColor(lightColor);
            darkColor = convertColor(darkColor);
            bgColor = convertColor(bgColor);
            transparentColor = "black";
            $helperNode[0].style.filter = "chroma(color='#000000')";
        }
        var init = (function($n){
            return function(){
                var p = $n.position();
                dims = {
                    top: p.top,
                    left: p.left,
                    width: parseInt($n.css("width")),
                    height: parseInt($n.css("height"))
                };
            }
        })($node);
        init();
        hs = {
            position: "absolute",
            top: dims["top"] + "px",
            left: dims["left"] + "px",
            height: "0",
            width: "0",
            zIndex: args.zIndex || (s.zIndex || 0),
            border: "0 solid " + transparentColor,
            fontSize: "0"
        };
        dims["endHeight"] = dims["height"] * pConst; 
        dims["endWidth"] = dims["width"] * pConst; 
        var props = [ {}, 
            {
                top: dims["top"],
                left: dims["left"]
            }
        ];
        var dynProperties = {
            left: [leftConst, rightConst, topConst, bottomConst, widthConst, heightConst, "end" + heightConst, leftConst],
            right: [rightConst, leftConst, topConst, bottomConst, widthConst, heightConst, "end" + heightConst, leftConst],
            top: [topConst, bottomConst, leftConst, rightConst, heightConst, widthConst, "end" + widthConst, topConst],
            bottom: [bottomConst, topConst, leftConst, rightConst, heightConst, widthConst, "end" + widthConst, topConst] 
        }
        // property names
        pn = dynProperties[dir];

        staticProps[pn[5].toLowerCase()] = dims[pn[5].toLowerCase()] + "px";
        staticProps[pn[4].toLowerCase()] = "0";
        staticProps[borderConst + pn[1] + widthConst] = dims[pn[4].toLowerCase()] + "px";
        staticProps[borderConst + pn[1] + "Color"] = bgColor;

        var p0 = props[0];
        p0[borderConst + pn[1] + widthConst] = 0 + "px"; 
        p0[borderConst + pn[1] + "Color"] = darkColor; 
        p0[borderConst + pn[2] + widthConst] = (dims[pn[6]] / 2) + "px";
        p0[borderConst + pn[3] + widthConst] = (dims[pn[6]] / 2) + "px";
        p0[pn[2].toLowerCase()] = (dims[pn[2].toLowerCase()] - dims[pn[6]] / 8) + "px";
        p0[pn[7].toLowerCase()] = (dims[pn[7].toLowerCase()] + dims[pn[4].toLowerCase()] / 2) + "px";
        p0[pn[5].toLowerCase()] = (dims[pn[6]]) + "px";

        var p1 = props[1];
        p1[borderConst + pn[0] + "Color"] = endColor;
        p1[borderConst + pn[0] + widthConst] = dims[pn[4].toLowerCase()] + "px";
        p1[borderConst + pn[2] + widthConst] = 0 + "px";
        p1[borderConst + pn[3] + widthConst] = 0 + "px";
        p1[pn[5].toLowerCase()] = dims[pn[5].toLowerCase()];

        $.extend(hs, staticProps);
        $helperNode.css(hs);
        $("body").append($helperNode);

        var finalize = function(){
            $helperNode.remove();
            s.visibility = "visible";
            onEnd();
        };
        $node.css("visibility", "hidden");
        $helperNode.animate(p0, duration).animate(p1, duration, null, finalize);
        return this;
};
 