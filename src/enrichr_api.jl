

function load_genelist(genelist, description="entest")
    url = "http://maayanlab.cloud/Enrichr/addList"
    genestr = join(genelist, "\n")
    payload = Dict("list" => genestr, "description" => description)
    r = requests.post(url, files=payload)
    !r.ok && error("Error loading list")
    JSON.parse(r.text)
end

function view_genelist(config)
    url = string("http://maayanlab.cloud/Enrichr/view?userListId=", config["userListId"])
    r = requests.get(url)
    !r.ok && error("Error fetching results")
    JSON.parse(r.text)
end


function enrichment(config, geneset)
    url = "http://maayanlab.cloud/Enrichr/enrich"
    querystring = string("?userListId=", config["userListId"], "&backgroundType=", geneset)
    r = requests.get(string(url, querystring))
    !r.ok && error("Error fetching results")
    data = JSON.parse(r.text)

    df = DataFrame(GeneSet=String[], Rank=Int[], Term=String[], pvalue=Float64[], zscore=Float64[], Combined=Float64[], Genes=Vector{String}[], padj=Float64[])

    for record in data[geneset]
        push!(df, ([geneset ; record[1:end-2]]))
    end
    df
end
