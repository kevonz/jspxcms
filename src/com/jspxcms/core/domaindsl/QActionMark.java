package com.jspxcms.core.domaindsl;

import static com.mysema.query.types.PathMetadataFactory.forVariable;

import com.jspxcms.core.domain.ActionMark;
import com.mysema.query.types.Path;
import com.mysema.query.types.PathMetadata;
import com.mysema.query.types.path.BooleanPath;
import com.mysema.query.types.path.EntityPathBase;
import com.mysema.query.types.path.NumberPath;
import com.mysema.query.types.path.StringPath;

public class QActionMark extends EntityPathBase<ActionMark> {

	private static final long serialVersionUID = -1808436415;

	public static final QActionMark actionMark = new QActionMark("actionMark");

	public final StringPath ftype = createString("ftype");

	public final NumberPath<Integer> fid = createNumber("fid",
			Integer.class);

	public final NumberPath<Integer> id = createNumber("id", Integer.class);

	public final StringPath mark = createString("mark");

	public final BooleanPath userid = createBoolean("userid");

	public QActionMark(String variable) {
		super(ActionMark.class, forVariable(variable));
	}

	@SuppressWarnings("all")
	public QActionMark(Path<? extends ActionMark> path) {
		super((Class) path.getType(), path.getMetadata());
	}

	public QActionMark(PathMetadata<?> metadata) {
		super(ActionMark.class, metadata);
	}

}
