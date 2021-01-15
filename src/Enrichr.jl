module Enrichr

import JSON
using DataFrames
using PyCall
requests = pyimport("requests")


export enrichr_genesets, load_genelist, view_genelist, enrichment
include("enrichr_term_lists.jl")
include("enrichr_api.jl")

end
