function video_name = choose_video(base_path)

	%process path to make sure it's uniform
	if ispc(), base_path = strrep(base_path, '\', '/'); end
	if base_path(end) ~= '/', base_path(end+1) = '/'; end
	
	%list all sub-folders
	contents = dir(base_path);
	names = {};
	for k = 1:numel(contents),
		name = contents(k).name;
		if isdir([base_path name]) && ~any(strcmp(name, {'.', '..'})),
			names{end+1} = name;  %#ok
		end
	end
	
	%no sub-folders found
	if isempty(names), video_name = []; return; end
	for i = 1:numel(names)
		fprintf('%d,%12s\t\t',i,names{i});
		if mod(i,2)==0
			fprintf('\n');
        end
    end
    fprintf('\n');
	choice=input('Input the video number:');
	if isempty(choice)||choice>numel(names),  %user cancelled
		video_name = [];
	else
		video_name = names{choice};
	end
	
end

