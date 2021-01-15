__precompile__()
module Enrichr

import JSON
using DataFrames
using PyCall

const requests = PyNULL()

function __init__()
    copy!(requests, pyimport("requests"))
end


export enrichr_genesets, load_genelist, view_genelist, enrichment
include("enrichr_term_lists.jl")
include("enrichr_api.jl")

end
