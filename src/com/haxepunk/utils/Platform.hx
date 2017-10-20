package haxepunk.utils;
import haxe.ds.StringMap;

#if macro
import haxe.macro.Context;

@:dox(hide)
class Platform
{
	static function run()
	{
		// suppress warnings for legacy
		Context.onTypeNotFound(function (typeName:String)
		{
			var parts = typeName.split(".");
			var suppressedAllowed:StringMap<Bool> = [
				"String" => true,
				"Math" => true,
				"Reflect" => true,
				"Array" => true,
				"Std" => true,
				"Lambda" => true,
				"gui" => true,
			];
			if (parts[0] == "com" && parts[1] == "haxepunk")
			{
				if (parts.length >= 3 && suppressedAllowed.get(parts[2])) {
					
				}
				else {
					var name = parts[parts.length - 1],
					currentPack = parts.slice(1, parts.length - 1),
					deprecatedPack = parts.slice(0, parts.length - 1);
					trace('Warning: the com.haxepunk package is deprecated ($typeName -> ' + currentPack.join(".") + '.$name)');
					trace("See MIGRATION.md for help updating your project to use HaxePunk 4.0");
				}
			
				return null;
				// returning null to let it still compile...
				// {name: name, pack: deprecatedPack, kind: TDAlias(TPath({name: name, pack: currentPack})), fields: [], pos: Context.currentPos()};
			}
			return null;
		});
	}
}
#end
