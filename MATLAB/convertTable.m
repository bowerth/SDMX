% Copyright 2010,2014 Bank Of Italy
%
% Licensed under the EUPL, Version 1.1 or - as soon they
% will be approved by the European Commission - subsequent
% versions of the EUPL (the "Licence");
% You may not use this work except in compliance with the
% Licence.
% You may obtain a copy of the Licence at:
%
%
% http://ec.europa.eu/idabc/eupl
%
% Unless required by applicable law or agreed to in
% writing, software distributed under the Licence is
% distributed on an "AS IS" basis,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
% express or implied.
% See the Licence for the specific language governing
% permissions and limitations under the Licence.
%

function tsTable = convertTable(ds) 

    %check arguments
    if nargin ~= 1
        error(sprintf(['Usage: convert(list)\n' ...
                    'Arguments\n' ...
                    'list: a it.bancaditalia.oss.sdmx.api.PortableDataSet of SDMX TimeSeries']));
    end
     
    %check class
    if (~ isa(ds,'it.bancaditalia.oss.sdmx.api.PortableDataSet'))
        error('SDMX convert(list) error: input list must be of class it.bancaditalia.oss.sdmx.api.PortableDataSet.');
    end
    
    values = cell(ds.getObservations);
    times = cell(ds.getTimeStamps);
    dimNames = cell(ds.getMetadataNames);
    
    nMeta = length(dimNames);
    metadata = cell(1, nMeta);
    for i = 1:nMeta
        metadata{i} = cell(ds.getMetadata(dimNames(i)));
    end
    
    tsTable = table(times, values, metadata{:});
    tsTable.Properties.VariableNames = ['TIME_PERIOD'; 'OBS_VALUE'; dimNames];
end