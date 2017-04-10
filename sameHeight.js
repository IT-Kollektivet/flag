"use strict"

const flags_without_viewbox = document.querySelectorAll("svg:not([viewBox])")
const flags_with_viewbox = []
flags_with_viewbox.push.apply(flags_with_viewbox, document.querySelectorAll("svg[viewBox]"))

//setViewBox( getSizes(flags_without_viewbox) ).concat(flags_with_viewbox)
var flags = getSizes(flags_without_viewbox)
console.log(flags[0], flags.length)

setViewBox(flags)

setHeight(
	flags.map(flag=> flag.node).concat(flags_with_viewbox)
)


function getSizes(svgs) {
	const flags = []
	svgs.forEach(flag => {
		const size = { w: flag.getAttribute("width"), h: flag.getAttribute("height"), node: flag }
		flags.push(size)
	})

	return flags
}

function setViewBox(flags) {
	flags.forEach(flag => {
		flag.node.setAttribute("viewBox", `0 0 ${flag.w} ${flag.h}`)
	})

	return flags
}

function setHeight(flags) {
	if(!Array.isArray(flags)) throw new TypeError("flags is not an array")

	flags.forEach(flag => {
		flag.removeAttribute("width")
		flag.setAttribute("height", "60px")
	})

	return flags
}

