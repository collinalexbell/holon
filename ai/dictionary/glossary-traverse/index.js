const axios = require("axios");

function get_word_data() {}

const IS_PREVIEW = false;

async function main() {
    const url = "http://www.catb.org/jargon/html/go01.html";
    const base_url = "http://www.catb.org/jargon/html/";
    console.log("url: ", url)

    const glossary_home = await axios.get(url);

    const jsdom = require("jsdom");
    const dom = new jsdom.JSDOM(glossary_home.data);
    const $ = require("jquery")(dom.window);

    const a = $("a")

    console.log("# links : ", a.length);
    console.log("link keys: ", Object.keys(a.get(0)));
    let word_url_list = [];
    a.each(function (index) {
        word_url_list.push($(this).attr('href'));
    });

    word_url_list = word_url_list.filter(url => {
        // hard coded
        if(!url) {
            return false;
        }
        const lexicon = url.search("html/lexicon.html");
        if(lexicon >= 0) {
            return false;
        }
        const slash = url.search("/");
        if(slash < 0) {
            // no slash
            return false;
        }
        return true;
    });
    console.log("# words", word_url_list.length);

    const word_urls_filtered = word_url_list.slice(0,1000);
    const data = word_urls_filtered.map((url, index) => {
        if(IS_PREVIEW) {
            return new Promise((resolve, _reject) => resolve(""));
        } else {
            return axios.get(base_url + url).then(res =>
                {
                    const word_dom = new jsdom.JSDOM(res.data);
                    const word$ = require("jquery")(word_dom.window);
                    const grammar = word$(".grammar");
                    const name = word$("b");
                    return {grammar: grammar.text(), name: name.text()};

                }
            );
        }
    });
    if(IS_PREVIEW) {
        console.log(await data[0] ? data[0] : "null");
    }
    const raw_glossary = await Promise.all(data.map(datum => datum.then((glossary_entry) => ({grammar: glossary_entry.grammar, name: glossary_entry.name}))));
    const glossary = raw_glossary.filter(entry => entry.grammar.length > 0).map(entry => ({...entry, grammar: entry.grammar.replace(/\./g, "").split(",")}));

    const parts_of_speech = [... new Set(glossary.flatMap(entry => entry.grammar))];
    console.log(parts_of_speech);

    const entries = [['n'], ['v', 'vt']].map(part_of_speech => {
        return {[part_of_speech]: glossary.filter(entry => entry.grammar.find(elem => part_of_speech.includes(elem)))};
    });

    function lispify_list(entries_for_part_of_speech) {
        //return Object.entries(entries_for_part_of_speech).map(([key, val]) => `key:${key}, val:${val}`);
        return `(${Object.values(entries_for_part_of_speech).map(entries => entries.map(entry => `"${entry.name}"`).join(" " )).join(" ")})`;
    }

    console.log(entries);
    const lisp = `'(${Object.entries(entries).map(([part_of_speech, entries_for_part_of_speech]) => {
        return `(${part_of_speech} . ${lispify_list(entries_for_part_of_speech)} )`;
    }).join(" ")})`;
    console.log(lisp);

}

main();
