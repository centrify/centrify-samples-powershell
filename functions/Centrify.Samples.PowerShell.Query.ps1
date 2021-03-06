# Copyright 2016 Centrify Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

function Query {
    param(
        [Parameter(Mandatory=$true)]
        $endpoint,
        [Parameter(Mandatory=$true)]
        $bearerToken,
        [Parameter(Mandatory=$true)]
        $query
    )
    
    $restArg = @{}
    $restArg.Script = $query
    $restArg.Args = @{}
    $restArg.Args.PageNumber = 1
    $restArg.Args.PageSize = 10000
    $restArg.Args.Limit = 10000
    $restArg.Args.Caching = -1
    
    $queryResult = Centrify-InvokeREST -Method "/redrock/query" -Endpoint $endpoint -Token $bearerToken -ObjectContent $restArg -Verbose:$enableVerbose
    if($queryResult.success -ne $true)
    {
        throw "Server error: $($queryResult.Message)"
    }     
    
    return $queryResult.Result
}
