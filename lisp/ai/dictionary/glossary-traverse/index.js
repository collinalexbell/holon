import $ from "jquery";
import axios from "axios";

const url = "http://www.catb.org/jargon/html/go01.html";

const glossary_home = await axios.get(url);


